package blok.core.foundation.suspend;

import haxe.Timer;

enum SuspendTrackerStatus {
  Ready;
  Waiting(num:Int);
}

// Note: Fallback is intentionally null -- the use of the Tracker is optional.
@service(fallback = null)
class SuspendTracker implements Service {
  final tracked:Array<Suspend> = [];
  public final status:Observable<SuspendTrackerStatus> = new Observable(Waiting(0));

  public function new() {}

  public inline function whenComplete(cb:()->Void) {
    return status.observe(status -> switch status {
      case Waiting(_):
      case Ready: cb();
    });
  }
  
  public function track(item:Suspend) {
    if (!tracked.contains(item)) {
      tracked.push(item);
      status.update(Waiting(tracked.length));
      Timer.delay(() -> {
        if (tracked.contains(item)) {
          throw 'Suspense tracking stalled out after 20000ms with ${tracked.length} remaining';
        }
      }, 20000);
    }
  }

  public function markComplete(item:Suspend) {
    if (tracked.contains(item)) {
      tracked.remove(item);
      Timer.delay(maybeDispatch, 100);
    }
  }

  function maybeDispatch() {
    if (tracked.length == 0) {
      status.update(Ready);
    } else {
      status.update(Waiting(tracked.length));
    }
  }
}