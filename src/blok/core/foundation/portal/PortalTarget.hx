package blok.core.foundation.portal;

class PortalTarget extends Component {
  @use var state:PortalState;

  @before
  public function register() {
    state.registerTarget(this);
  }

  function render() {
    return [];
  }
}
