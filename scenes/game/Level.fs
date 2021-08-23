namespace BloodFeverFs.Scene

open BloodFeverFs.Actors
open Godot
open KSGodot
open KSGodotUtils

type Level() =
    inherit Base()

    member val ZombieTemplate = GD.Load<PackedScene>("res://actors/zombie/Zombie.tscn")

    member this.UI() = this.getNode ("UI")

    member this.Draco() = this.getNode<Actor> ("actors/Draco")

    member this.Actors() = this.getNode ("actors")

    member val stickInstance: Option<Stick> = None with get, set

    member this.Stick() =
        match this.stickInstance with
        | Some stick -> stick
        | None ->
            let s = (Stick(this.getNode ("UI/Stick")))
            this.stickInstance <- Some s
            s

    override this._Process(delta) =
        base._Process (delta)
        this.Draco().LinearVelocity <- this.Stick().Output() * 2f

    member this.OnSpawnTimer() =

        let mobSpawnLocation =
            this.getNode<PathFollow2D> ("SpawnPath/SpawnLocation")

        mobSpawnLocation.Offset <- float32 (this.NextRandom())

        let mobInstance = this.ZombieTemplate.Instance() :?> Actor
        this.Actors().AddChild(mobInstance)

        mobInstance.Position <- mobSpawnLocation.Position
