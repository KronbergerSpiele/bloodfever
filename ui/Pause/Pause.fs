namespace BloodFeverFs.UI

open Godot
open KSGodotUtils

type Pause() =
    inherit Node2D()

    member this.Overlay() = this.getNode<Node2D> ("Overlay")

    override this._EnterTree() =
        base._EnterTree ()
        this.Overlay().Visible <- false

    override this._Ready() =
        base._Ready ()
        this.Overlay().Visible <- false

    member this.OnPauseButtonPressed() = 
        this.GetTree().SetInputAsHandled()
