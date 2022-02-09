import BackgroundAudio from "./ksgodot/audio/BackgroundAudio";

export default class Global extends Node {
  lastSceneSnapshot: ImageTexture | null = null;
  lastSceneLayer: CanvasLayer | null = null;
  lastScene: Node2D | null = null;

  get BackgroundAudio() {
    return this.get_node<BackgroundAudio>("/root/AudioManager");
  }
}
