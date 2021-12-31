package blok.foundation.portal;

import blok.context.Provider;
import blok.ui.Component;
import blok.ui.VNode;
import blok.ui.Fragment;

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
