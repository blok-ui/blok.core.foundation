package blok.core.foundation.suspend;

import haxe.Exception;

class RequestSuspensionException extends Exception {
  public final next:(resume:()->Void)->Void;

  public function new(next) {
    super('A suspension was unhandled');
    this.next = next;
  }
}
