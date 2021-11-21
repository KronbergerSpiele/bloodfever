class Pause extends Node2D {
  get Overlay() {
    return this.get_node_unsafe<Node2D>("Overlay");
  }

  _enter_tree() {
    this.Overlay.visible = false;
  }

  _ready() {
    this.Overlay.visible = false;
  }

  onPauseButtonPressed() {
    this.get_tree().set_input_as_handled();
  }
}
