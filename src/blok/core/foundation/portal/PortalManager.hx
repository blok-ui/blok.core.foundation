package blok.core.foundation.portal;

import blok.Component;
import blok.Context;
import blok.VNode;

class PortalManager extends Component {
  @prop var children:Array<VNode>;

  override function render(context:Context):VNode {
    return PortalState.provide({}, childContext -> VFragment([
      PortalState.target(childContext),
      VFragment(children, Type.getClassName(PortalManager))
    ]));
  }
}
