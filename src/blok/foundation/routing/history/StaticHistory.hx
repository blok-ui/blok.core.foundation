package blok.foundation.routing.history;

import blok.state.Observable;

using StringTools;

class StaticHistory implements History {
  final location:Observable<String>;
  var urls:Array<String>;

  public function new(initialUrl:String) {
    urls = [ initialUrl ];
    location = new Observable(getLocation());
  }

  public function getObservable() {
    return location;
  }

  public function getLocation():String {
    return urls.length == 0 ? '' : urls[urls.length - 1];
  }

  public function previous():Null<String> {
    urls.pop();
    return getLocation();
  }

  public function next():Null<String> {
    return getLocation();
  }

  public function push(url:String):Void {
    urls.push(url);
    location.update(getLocation());
  }
}
