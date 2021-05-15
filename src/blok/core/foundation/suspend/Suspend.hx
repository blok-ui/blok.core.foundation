package blok.core.foundation.suspend;

import haxe.Exception;
import blok.exception.WrappedException;

class Suspend extends Component {
  public inline static function suspend(next) {
    throw new RequestSuspensionException(next);
  }

  public inline static function await(build, fallback) {
    return node({
      build: build,
      fallback: fallback
    });
  }

  @prop var build:()->VNode;
  @prop var fallback:()->VNode;
  @use var tracker:SuspendTracker;

  override function componentDidCatch(exception:Exception) {
    return switch Std.downcast(exception, WrappedException) {
      case null: 
        super.componentDidCatch(exception);
      case wrapped: switch Std.downcast(wrapped.target, RequestSuspensionException) {
        case null: 
          super.componentDidCatch(exception);
        case request:
          if (tracker != null) tracker.track(this);
          request.next(() -> {
            if (tracker != null) tracker.markComplete(this);
            // Ensure we don't throw an error if this component is removed.
            if (__isMounted) updateComponent();
          });
          fallback();
      }
    }
  }

  public function render() {
    return build();
  }
}
