namespace BloodFeverFs.Scene

open KSGodotUtils
open Godot

type Loading() =
    inherit Base()

    override this._Ready() =
        base._Ready()
        this.getNode<Timer>("Timer").Start()

    member this.OnTimerTimeout() =
        this.SwitchTo("res://scenes/menu/Menu.tscn")
