package blok.core.foundation.suspend;

import haxe.Exception;
import blok.exception.WrappedException;

class Suspend extends Component {
  public inline static function suspend(next):VNode {
    throw new RequestSuspensionException(next);
  }

  public inline static function await(build, fallback) {
    return node({
      build: build,
      fallback: fallback
    });
  }

  @prop var build:()->VNodeResult;
  @prop var fallback:()->VNodeResult;
  @use var tracker:SuspendTracker;

  var isTracking:Bool = false;

  @effect
  function maybeMarkComplete() {
    if (isTracking) {
      isTracking = false;
      if (tracker != null) tracker.markComplete(this);
    }
  }

  override function componentDidCatch(exception:Exception) {
    return switch Std.downcast(exception, WrappedException) {
      case null: 
        super.componentDidCatch(exception);
      case wrapped: switch Std.downcast(wrapped.target, RequestSuspensionException) {
        case null: 
          super.componentDidCatch(exception);
        case request:
          if (tracker != null) tracker.track(this);
          getPlatform().scheduler.schedule(() -> {
            request.next(() -> {
              switch __status {
                case WidgetValid:
                  isTracking = true;
                  invalidateWidget();
                default:
                  if (tracker != null) tracker.markComplete(this);
              }
            });
          });
          fallback();
      }
    }
  }

  public function render() {
    return build();
  }
}
