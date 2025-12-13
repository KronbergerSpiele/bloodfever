class_name Base extends Node2D

@export var backgroundMusic: AudioStream = null

@onready var page: Page = $CanvasLayer/Page
var random = RandomNumberGenerator.new()

func nextRandom() -> float:
  return random.randf()

func _ready():
  random.randomize()
  
  # Handle page transition (only if page exists)
  var snapshot = GlobalManager.lastSceneSnapshot
  if page:
    if snapshot:
      page.startWith(snapshot, snapshot)
    else:
      page.visible = false
  
  (GlobalManager as Global).BackgroundAudio().playBackground(backgroundMusic)

var ticks: int = 0
func _process(_delta: float):
  ticks += 1
  if ticks > 2:
    var global = GlobalManager as Global
    if global.lastScene != self and global.lastSceneLayer:
      var root = get_tree().root
      if root and global.lastSceneLayer.get_parent() == root:
        root.remove_child(global.lastSceneLayer)
        global.lastSceneLayer.queue_free()
      global.lastSceneLayer = null

func switchTo(scene):
  var root = get_tree().root
  var viewport = get_viewport()
  
  # Wait for rendering to complete before capturing
  await RenderingServer.frame_post_draw
  
  # Capture viewport texture
  var img: Image = null
  var viewport_tex = viewport.get_texture()
  if viewport_tex:
    img = viewport_tex.get_image()
  
  # Fallback: create empty image if capture failed
  if not img:
    var vp_size = viewport.get_visible_rect().size
    img = Image.create(int(vp_size.x), int(vp_size.y), false, Image.FORMAT_RGBA8)
    img.fill(Color(0.1, 0.1, 0.1, 1.0))
  
  # Scale snapshot to target resolution
  var scaleX = 480.0 / img.get_width()
  var scaleY = 320.0 / img.get_height()
  
  # Store snapshot for next scene transition
  var tex = ImageTexture.create_from_image(img)
  var global = GlobalManager as Global
  global.lastSceneSnapshot = tex
  
  # Create overlay layer with snapshot BEFORE scene change
  var layer = CanvasLayer.new()
  layer.layer = 99
  
  var sprite = Sprite2D.new()
  sprite.texture = tex
  sprite.position = Vector2(240, 160)
  sprite.scale = Vector2(scaleX, scaleY)
  layer.add_child(sprite)
  root.add_child(layer)
  
  global.lastSceneLayer = layer
  global.lastScene = self
  
  # Change scene (must be last)
  get_tree().change_scene_to_file(scene)
