package blok.core.foundation.portal;

import blok.Component;
import blok.VNode;

class PortalManager extends Component {
  @prop var children:Array<VNode>;

  public function render() {
    return PortalState.provide({}, context -> Fragment.wrap(
      ...[ PortalState.targetFrom(context) ].concat(children)
    ));
  }
}
