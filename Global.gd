extends Node
class_name Global

var lastSceneSnapshot = null
var lastSceneLayer = null
var lastScene = null

func BackgroundAudio() -> BackgroundAudio:
  return $"/root/AudioManager" as BackgroundAudio
