namespace BloodFeverFs.UI

open Godot
open KSGodotUtils

type Lifebar() =
    inherit Node2D()

    [<Export>]
    member val Health = 100 with get, set

    [<Export>]
    member val HealthIncome = 0 with get, set

    member this.Bar() = this.getNode<TextureProgress> ("Bar")

    override this._Process(delta) =
        base._Process (delta)
        this.Health <- this.Health + this.HealthIncome

        this.HealthIncome <- 0
        this.Bar().Value <- float this.Health
