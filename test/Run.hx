import Blok.Provider;
import blok.Service;
import js.Browser;
import blok.dom.Platform;
import haxe.Timer;
import blok.Html;
import blok.Component;
import blok.core.foundation.suspend.Suspend;
import blok.core.foundation.suspend.SuspendTracker;

function main() {
  var tracker = new SuspendTracker();
  tracker.whenComplete(() -> trace('done'));
  Platform.mount(
    Browser.document.getElementById('root'),
    Provider.provide(tracker, context -> Html.fragment(
      Wrapper.node({ delay: 1000 }),
      Wrapper.node({ delay: 2000 }),
      Wrapper.node({ delay: 4000 }),
      Wrapper.node({ delay: 3000 }),
      tracker.status.mapToVNode(status -> switch status {
        case Waiting(num): Html.text('Waiting on ${num}');
        case Ready: Html.text('Done');
      })
    ))
  );
}

class Wrapper extends Component {
  @prop var delay:Int;
  
  public function render() {
    return Provider.provide(new AsyncService(delay), context ->
      Suspend.await(
        () -> WillSuspend.node({}), 
        () -> Placeholder.node({})
      )
    );
  }
}

@service(fallback = null)
class AsyncService implements Service {
  public var value:String = null;
  final delay:Int;
  
  public function new(delay) {
    this.delay = delay;
  }

  public function get() {
    if (value == null) {
      Suspend.suspend(resume -> {
        value = 'Ok!';
        Timer.delay(resume, delay);
      });
    }
    return value;
  }
}

class WillSuspend extends Component {
  @use var service:AsyncService;

  public function render() {
    return Html.div({}, Html.text(service.get()));
  }
}

class Placeholder extends Component {
  @prop var dots:Int = 1;
  var timer:Timer;

  @init
  public function setup() {
    timer = new Timer(20);
    timer.run = increment;
  }

  @dispose
  public function cleanup() {
    timer.stop();
    timer = null;
  }

  @update
  public function increment() {
    return UpdateState({ dots: dots + 1 });
  }

  public function render() {
    return Html.div({},
      Html.text('Waiting' + [ for (_ in 0...dots) '.' ].join(''))
    );
  }
}
