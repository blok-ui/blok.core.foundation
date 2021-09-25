package blok.core.foundation.portal;

/**
  The PortalService is responsible for managing all Portals in a Blok app.
  You should generally need only one PortalService.
**/
@service(fallback = new PortalService())
class PortalService implements Service {
  var currentTarget:PortalTarget = null;

  public function new() {}
  
  public function registerTarget(target:PortalTarget) {
    currentTarget = target;
  }

  public function getTarget() {
    return currentTarget;
  }

}
