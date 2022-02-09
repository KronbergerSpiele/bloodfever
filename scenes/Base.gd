extends Node2D
class_name Base

export(AudioStream) var backgroundMusic = null

func Global() -> Global:
  return $"/root/GlobalManager" as Global
func Page() -> Page:
  return $CanvasLayer/Page as Page
  
var random = RandomNumberGenerator.new()
func nextRandom():
  return self.random.randf()

func _ready():
  self.random.randomize()
  self.Page().startWith(self.Global().lastSceneSnapshot, self.Global().lastSceneSnapshot)
  self.Global().BackgroundAudio().playBackground(self.backgroundMusic)

var ticks: int = 0
func _process(_delta: float):
  if self.ticks < 2:
    self.ticks += 1
  else:
    if self.Global().lastScene != self:
      var layer = self.Global().lastSceneLayer
      if layer:
        self.get_tree().root.remove_child(layer)
        self.Global().lastSceneLayer = null

func switchTo(scene):
  var oldTex = self.get_viewport().get_texture()
  
  var oldWidth = oldTex.get_width()
  
  var oldHeight = oldTex.get_height()
  
  var scaleX = 480.0 / oldWidth
  
  var scaleY = 320.0 / oldHeight
  
  var img = oldTex.get_data()
  
  img.flip_y()
  var tex = ImageTexture.new()
  
  tex.create_from_image(img, 0)
  self.Global().lastSceneSnapshot = tex
  var _err = self.get_tree().change_scene(scene)
  
  var layer = CanvasLayer.new()
  
  layer.layer = 99
  var tmp = Sprite.new()
  
  tmp.texture = tex
  tmp.position = Vector2(240, 160)
  tmp.scale = Vector2(scaleX, scaleY)
  layer.add_child(tmp)
  self.get_tree().root.add_child(layer)
  self.Global().lastSceneLayer = layer
  self.Global().lastScene = self

