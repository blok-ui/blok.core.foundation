package blok.core.foundation.suspend;

class DisposableCallback implements Disposable {
  var cb:()->Void;

  public function new(cb) {
    this.cb = cb;
  }

  public function dispose() {
    cb = null;
  }

  public function call() {
    if (cb != null) cb();
    dispose();
  }
}