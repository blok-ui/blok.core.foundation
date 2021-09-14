package blok.core.foundation.portal;

import haxe.ds.ReadOnlyArray;

using Blok;
using Lambda;

typedef PortalEntry = { key:String, vnode:VNode }; 

// @todo: this can probably just be a Service now, but for the moment
//        it works without us needing to change the API at all.
/**
  The PortalState is responsible for managing all Portals in a Blok app.
  You should generally need only one PortalState.
**/
@service(fallback = new PortalState({}))
final class PortalState implements State {
  @prop var currentTarget:PortalTarget = null;

  /**
    Create a Portal target. This is where all views added to the
    portal will be rendered.

    Note: currently you can only use one target -- this will get set
    to whatever the *last* target you create.
  **/
  public inline static function target() {
    return use(state -> PortalTarget.node({}));
  }

  /**
    Use this method when you already have access to `Context` (for example,
    inside a `Provider.provide(service, context -> ...)` method or in a 
    `Context.use(context -> ...)` method).
  **/
  public static function targetFrom(context:Context) {
    return observe(context, state -> PortalTarget.node({}));
  }
  
  @update
  public function registerTarget(target:PortalTarget) {
    return UpdateState({
      currentTarget: target
    });
  }

  public function getTarget() {
    return currentTarget;
  }
}
