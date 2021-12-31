package blok.foundation.a11y;

import blok.context.Service;
import blok.ui.ConcreteWidget;

@service(fallback = new FocusManager())
class FocusManager implements Service {
  public function new() {}

  public function setFocus(ref:ConcreteWidget) {
    #if blok.platform.dom
      var el:js.html.Element = ref.toConcrete().first();
      el.focus();
    #end
  }
}
