export default class Lifebar extends Node2D {
  @exports
  health: int = 100;

  @exports
  healthIncome: int = 0;

  get Bar() {
    return this.get_node("Bar");
  }

  _process(delta: float) {
    this.health += this.healthIncome;
    this.healthIncome = 0;
    this.Bar.value = this.health;
  }
}
