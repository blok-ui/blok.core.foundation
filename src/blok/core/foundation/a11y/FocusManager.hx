package blok.core.foundation.a11y;

@service(fallback = new FocusManager())
class FocusManager implements Service {
  public function new() {}

  public function setFocus(ref:ConcreteWidget) {
    #if blok.platform.dom
      var el:js.html.Element = ref.getFirstConcreteChild();
      el.focus();
    #end
  }
}
