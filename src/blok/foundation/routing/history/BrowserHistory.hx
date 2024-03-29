package blok.foundation.routing.history;

import js.Browser;
import haxe.io.Path;
import blok.state.Observable;

using StringTools;

class BrowserHistory implements History {
  final location:Observable<String>;
  var root:String;

  public function new(?root) {
    this.root = root;
    location = new Observable(getLocation());
    Browser.window.addEventListener('popstate', (e) -> {
      location.update(getLocation());
    });
  }

  public function getObservable() {
    return location;
  }
  
  public function getLocation():String {
    var path = Browser.location.pathname + Browser.location.hash + Browser.location.search;
    // todo: what are we actually doing with `root`.
    if (root != null && path.startsWith(root)) {
      return path.substring(root.length);
    }
    return path;
  }

  public function previous():Null<String> {
    Browser.window.history.back();
    return getLocation();
  }

  public function next():Null<String> {
    Browser.window.history.forward();
    return getLocation();
  }

  public function push(url:String):Void {
    Browser.window.history.pushState(null, null, Path.join([ root, url ]));
    location.update(getLocation());
  }
}
