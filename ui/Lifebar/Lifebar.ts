class Lifebar extends Node2D {
  @exports
  health = 100;

  @exports
  healthIncome = 0;

  get Bar() {
    return this.get_node_unsafe<TextureProgress>("Bar");
  }

  _process(delta: float) {
    this.health += this.healthIncome;
    this.healthIncome = 0;
    this.Bar.value = this.health;
  }
}
