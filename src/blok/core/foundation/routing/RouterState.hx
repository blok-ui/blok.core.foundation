package blok.core.foundation.routing;

import blok.Observable;

using Blok;

// @todo: figure out how to handle the fallback here.
@service(fallback = null)
class RouterState<Route:EnumValue> implements State {
  @prop public var urlToRoute:(url:String)->Route;
  @prop public var routeToUrl:(route:Route)->String;
  @prop final history:History;
  @prop var route:Route = null;
  @prop var url:String = null;

  var link:Disposable;

  @init
  function setup() {
    link = history.getObservable().observe(setUrl);
  }

  @dispose
  function cleanup() {
    link.dispose();
  }

  public function previous() {
    history.previous();
  }

  public function next() {
    history.next();
  }
  
  public function setRoute(route:Route) {
    if (!this.route.equals(route)) {
      history.push(routeToUrl(route));
    }
  }

  @update
  function setUrl(url:String) {
    var route = urlToRoute(url);
    if (this.route.equals(route)) return None;
    return UpdateState({
      url: url,
      route: route
    });
  }
}
