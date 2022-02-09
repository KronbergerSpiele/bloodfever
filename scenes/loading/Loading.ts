import Base from "../Base";

export default class Loading extends Base {
  get Timer() {
    return this.get_node("Timer");
  }

  _ready() {
    this.Timer.start();
  }

  onTimerTimeout() {
    this.switchTo("res://scenes/menu/Menu.tscn");
  }
}
