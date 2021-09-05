package blok.core.foundation.portal;

import haxe.ds.ReadOnlyArray;

using Blok;
using Lambda;

typedef PortalEntry = { key:String, vnode:VNode }; 

/**
  The PortalState is responsible for managing all Portals in a Blok app.
  You should generally need only one PortalState.
**/
@service(fallback = new PortalState({}))
final class PortalState implements State {
  /**
    Create a Portal target. This is where all views added to the
    portal will be rendered.
  **/
  public inline static function target() {
    return use(state -> Fragment.wrap(...state.portals.map(p -> p.vnode)));
  }

  /**
    Use this method when you already have access to `Context` (for example,
    inside a `Provider.provide(service, context -> ...)` method or in a 
    `Context.use(context -> ...)` method).
  **/
  public static function targetFrom(context:Context) {
    return observe(context, state -> Fragment.wrap(...state.portals.map(p -> p.vnode)));
  }
  
  @prop var portals:ReadOnlyArray<PortalEntry> = [];

  @update 
  public function addPortal(key:String, vnode:VNode) {
    if (portals.exists(entry -> entry.key == key)) return None;
    return UpdateState({
      portals: portals.concat([ { key: key, vnode: vnode } ])
    });
  }

  @update
  public function removePortal(key:String) {
    if (!portals.exists(entry -> entry.key == key)) return None;
    return UpdateState({ 
      portals: portals.filter(entry -> entry.key != key) 
    });
  }
}
