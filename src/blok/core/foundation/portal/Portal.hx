package blok.core.foundation.portal;

import blok.Component;
import blok.VNode;

class Portal extends Component {
  static var id:Int = 0;

  final key:String = 'portal_${id++}';
  
  @prop var child:VNode;
  @use var state:PortalState;

  @init
  function registerPortal() {
    state.addPortal(key, child);
  }

  @dispose
  function removePortal() {
    state.removePortal(key);
  }

  public function render() {
    return [];
  }
}
