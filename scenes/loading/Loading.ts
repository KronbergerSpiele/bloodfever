class Loading extends Base {
  get Timer() {
    return this.get_node_unsafe<Timer>("Timer");
  }

  _ready() {
    this.Timer.start();
  }

  onTimerTimeout() {
    this.switchTo("res://scenes/menu/Menu.tscn");
  }
}
