package blok.core.foundation.portal;

import haxe.ds.ReadOnlyArray;

using Blok;
using Lambda;

typedef PortalEntry = { key:String, vnode:VNode }; 

@service(fallback = PortalState.getFallback())
class PortalState implements State {
  static var __fallback:PortalState;

  public static function getFallback() {
    if (__fallback == null) {
      __fallback = new PortalState({});
    }
    return __fallback;
  }

  public static function target(context:Context) {
    return observe(context, state -> VFragment(state.portals.map(p -> p.vnode)));
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
