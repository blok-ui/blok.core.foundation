package blok.core.foundation.portal;

using Lambda;

// Note: This will only work for one Portal at a time, and is currently
//       more than a little hacky.
//
//       There may be a better solution, or we might need to take another
//       stab at the ConcreteManager.
class PortalProxyManager implements ConcreteManager {
  final proxy:ConcreteManager;
  final component:Component;

  public function new(component:Component, proxy:ConcreteManager) {
    trace(proxy);
    this.component = component;
    this.proxy = proxy;
  }

  public function toConcrete():Array<Dynamic> {
    // This hides from parent Widgets so they don't try managing
    // our concrete items for us.
    //
    // Note that this is hacky as hell, and probably a sign that this 
    // part of the API needs a serious rethink.
    return []; 
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
