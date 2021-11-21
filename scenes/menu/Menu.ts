class Menu extends Base {
  onStartPressed() {
    this.switchTo("res://scenes/game/Diner.tscn");
  }

  onAboutPressed() {
    this.switchTo("res://scenes/about/About.tscn");
  }
}
