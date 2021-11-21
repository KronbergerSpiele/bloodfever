class GlobalHelper extends Node {
  lastSceneSnapshot: ImageTexture | null = null;
  lastSceneLayer: CanvasLayer | null = null;
  lastScene: Node2D | null = null;

  get BackgroundAudio() {
    return this.get_node_unsafe<BackgroundAudio>("/root/Audio");
  }
}
