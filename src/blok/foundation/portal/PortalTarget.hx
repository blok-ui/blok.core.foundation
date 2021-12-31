package blok.foundation.portal;

import blok.ui.Component;

class PortalTarget extends Component {
  @use var portals:PortalService;

  @before
  public function register() {
    portals.registerTarget(this);
  }

  function render() {
    return [];
  }
}
