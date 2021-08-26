namespace BloodFeverFs

open BloodFeverFs.Audio

open Godot
open KSGodotUtils

type Global() =
    inherit Node()

    member val LastSceneSnapshot: Option<ImageTexture> = None with get, set
    member val LastSceneLayer: Option<CanvasLayer> = None with get, set
    member val LastScene: Option<Node2D> = None with get, set


    member this.Audio() = this.getNode<Audio> ("/root/Audio")
