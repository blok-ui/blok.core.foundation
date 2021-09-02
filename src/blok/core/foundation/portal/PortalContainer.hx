package blok.core.foundation.portal;

import blok.Component;
import blok.VNode;

/**
  A container component that sets up everything you need to use Portals.

  Note: if you *dont* use the PortalContainer, make sure you provide a
  PortalState and also call `PortalState.target(...)` or 
  `PortalState.targetFrom(...)` somehwere in your app.
**/
class PortalContainer extends Component {
  @prop var children:Array<VNode>;

  public function render() {
    return PortalState.provide({}, context -> Fragment.wrap(
      ...[ PortalState.targetFrom(context) ].concat(children)
    ));
  }
}
