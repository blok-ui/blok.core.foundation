package blok.core.foundation.a11y;

@service(fallback = FocusManager.getFallback())
class FocusManager implements Service {
  static var fallback:FocusManager;

  public static function getFallback() {
    if (fallback == null) {
      fallback = new FocusManager();
    }
    return fallback;
  }

  public function new() {}

  public function setFocus(ref:ConcreteWidget) {
    #if blok.platform.dom
      var el:js.html.Element = ref.getFirstConcreteChild();
      el.focus();
    #end
  }
}
