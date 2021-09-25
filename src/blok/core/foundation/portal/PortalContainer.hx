package blok.core.foundation.portal;

import blok.Component;
import blok.VNode;

/**
  A container component that sets up everything you need to use Portals.

  Note: if you *dont* use the PortalContainer, make sure you provide a
  PortalService and also call `PortalService.target(...)` or 
  `PortalService.targetFrom(...)` somehwere in your app.
**/
class PortalContainer extends Component {
  @prop var children:Array<VNode>;

  public function render() {
    return Provider.provide(new PortalService(), context -> Fragment.wrap(
      ...[ PortalTarget.node({}) ].concat(children)
    ));
  }
}
