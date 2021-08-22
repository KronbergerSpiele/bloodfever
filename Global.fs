namespace BloodFeverFs

open Godot

type Global() =
    inherit Node()

    member val LastSceneSnapshot: Option<ImageTexture> = None with get, set
    member val LastSceneLayer: Option<CanvasLayer> = None with get, set
    member val LastScene: Option<Node2D> = None with get, set
