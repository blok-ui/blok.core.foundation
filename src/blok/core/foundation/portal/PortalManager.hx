package blok.core.foundation.portal;

import blok.Component;
import blok.VNode;

class PortalManager extends Component {
  @prop var children:Array<VNode>;

  public function render():VNode {
    return PortalState.provide({}, context -> VFragment([
      PortalState.targetFrom(context),
      new VFragment(children)
    ]));
  }
}
