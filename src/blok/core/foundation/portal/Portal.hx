package blok.core.foundation.portal;

import blok.Component;
import blok.VNode;

/**
  A `Portal` is a component that renders its child elsewhere in 
  an app. This makes it super useful for things like modals or 
  popovers. 
**/
class Portal extends Component {
  static var id:Int = 0;

  final key:String = 'portal_${id++}';
  
  @prop var child:VNode;
  @use var portals:PortalService;

  override function __registerPlatform(platform:Platform) {
    __platform = platform;
    __manager = new PortalProxyManager(
      this, 
      portals.getTarget().getConcreteManager()
    );
    addDisposable(__manager);
  }

  public function render() {
    return child;
  }
}
