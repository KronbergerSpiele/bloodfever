# This file has been autogenerated by ts2gd. DO NOT EDIT!


tool
extends TextureButton
class_name SpeechBase







var LI setget , LI_get
export(String) var label setget label_set, label_get
func LI_get():
  return self.get_node("Label") if self.has_node("Label") else null
func label_set(text: String):
  if self.LI:
    self.LI.text = text
func label_get():
  var __gen = self.LI
  return ((__gen.text if __gen != null else null) if ((__gen.text if __gen != null else null)) != null else "")

