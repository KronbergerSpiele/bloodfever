class Base extends Node2D {
  @exports
  backgroundMusic: AudioStream | null = null;

  get Global() {
    return this.get_node_unsafe<GlobalHelper>("/root/Global");
  }

  get Page() {
    return this.get_node_unsafe<Page>("CanvasLayer/Page");
  }

  private random = new RandomNumberGenerator();

  nextRandom() {
    return this.random.randf();
  }

  constructor() {
    super();
    this.random.randomize();
    this.Page.startWith(
      this.Global.lastSceneSnapshot,
      this.Global.lastSceneSnapshot
    );

    this.Global.BackgroundAudio.playBackground(this.backgroundMusic);
  }

  private ticks = 0;
  _process() {
    if (this.ticks < 2) {
      this.ticks++;
    } else if (this.Global.lastScene !== this) {
      const layer = this.Global.lastSceneLayer;
      if (layer) {
        this.get_tree().root.remove_child(layer);
        this.Global.lastSceneLayer = null;
      }
    }
  }

  switchTo(scene: SceneName) {
    const oldTex = this.get_viewport().get_texture();
    const oldWidth = oldTex.get_width();
    const oldHeight = oldTex.get_height();
    const scaleX = 480.0 / oldWidth;
    const scaleY = 320.0 / oldHeight;
    const img = oldTex.get_data();
    img.flip_y();
    const tex = new ImageTexture();
    tex.create_from_image(img, 0);
    this.Global.lastSceneSnapshot = tex;
    const err = this.get_tree().change_scene(scene);
    const layer = new CanvasLayer();
    layer.layer = 99;
    const tmp = new Sprite();
    tmp.texture = tex;
    tmp.position = new Vector2(240, 160);
    tmp.scale = new Vector2(scaleX, scaleY);
    layer.add_child(tmp);
    this.get_tree().root.add_child(layer);
    this.Global.lastSceneLayer = layer;
    this.Global.lastScene = this;
  }
}
