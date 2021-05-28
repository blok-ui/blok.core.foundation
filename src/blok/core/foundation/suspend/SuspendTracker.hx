package blok.core.foundation.suspend;

enum SuspendTrackerStatus {
  Ready;
  Waiting(num:Int);
}

// Note: Fallback is intentionally null -- the use of the Tracker is optional.
@service(fallback = null)
class SuspendTracker implements Service {
  var isDispatching:Bool = false;
  final tracked:Array<Suspend> = [];
  final scheduler:Scheduler = DefaultScheduler.getInstance();
  public final status:Observable<SuspendTrackerStatus> = new Observable(
    Waiting(0), // Done to ensure we don't trigger `whenComplete` prematurely.
    (a, b) -> !a.equals(b)
  );

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
    }
  }

  public function markComplete(item:Suspend) {
    if (tracked.contains(item)) {
      tracked.remove(item);
      if (!isDispatching) {
        isDispatching = true;
        scheduler.schedule(() -> {
          maybeDispatch();
          isDispatching = false;
        });
      }
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
