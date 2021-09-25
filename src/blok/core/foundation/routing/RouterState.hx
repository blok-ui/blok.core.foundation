package blok.core.foundation.routing;

import blok.Observable;

using Blok;

@service(fallback = throw 'No router found.')
class RouterState<Route:EnumValue> implements State {
  @prop public var urlToRoute:(url:String)->Route;
  @prop public var routeToUrl:(route:Route)->String;
  @prop final history:History;
  @prop var route:Route = null;
  @prop var url:String = null;

  @init
  function setup() {
    addDisposable(history.getObservable().observe(setUrl));
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
    if (this.route.equals(route)) return {};
    return { url: url, route: route };
  }
}
