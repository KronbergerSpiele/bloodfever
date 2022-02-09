import Base from "../Base";

export default class About extends Base {
  onClose() {
    this.switchTo("res://scenes/menu/Menu.tscn");
  }
}
