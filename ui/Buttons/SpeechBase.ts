@tool
class SpeechBase extends TextureButton {
  get LI() {
    return this.has_node("Label") ? this.get_node_unsafe<Label>("Label") : null;
  }

  @exports
  set label(text: string) {
    if (this.LI) {
      this.LI.text = text;
    }
  }

  get label(): string {
    return this.LI?.text ?? "";
  }
}
