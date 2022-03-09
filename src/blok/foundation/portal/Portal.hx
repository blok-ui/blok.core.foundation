package blok.foundation.portal;

import blok.ui.ConcreteManager;
import blok.ui.Component;
import blok.ui.Platform;
import blok.ui.VNode;

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

  override function __createConcreteManager(platform:Platform):ConcreteManager {
    return new PortalProxyManager(
      this, 
      portals.getTarget().getConcreteManager()
    );
  }

  public function render() {
    return child;
  }
}
