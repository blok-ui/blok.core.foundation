package blok.core.foundation.portal;

using Lambda;

// @note: This won't work for more than one item in a Portal,
//        unfortunately. We'll need something more complex.
class PortalProxyManager implements ConcreteManager {
  final proxy:ConcreteManager;
  final component:Component;

  public function new(component:Component, proxy:ConcreteManager) {
    this.component = component;
    this.proxy = proxy;
  }

  public function toConcrete():Array<Dynamic> {
    var concrete = component.getConcreteChildren();
    return concrete.map(c -> c.toConcrete()).flatten();
  }
  
  public function getFirstConcreteChild():Dynamic {
    return proxy.getFirstConcreteChild();
  }

  public function getLastConcreteChild():Dynamic {
    return proxy.getLastConcreteChild();
  }

  public function addConcreteChild(child:Widget):Void {
    proxy.addConcreteChild(child);
  }

  public function insertConcreteChildAt(pos:Int, child:Widget):Void {
    proxy.insertConcreteChildAt(pos, child);
  }

  public function moveConcreteChildTo(pos:Int, child:Widget):Void {
    proxy.moveConcreteChildTo(pos, child);
  }

  public function removeConcreteChild(child:Widget):Void {
    proxy.removeConcreteChild(child);
  }

  public function dispose() {
    for (child in component.getChildren()) removeConcreteChild(child);
  }
}
