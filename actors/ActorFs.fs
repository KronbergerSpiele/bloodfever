namespace BloodFeverFs
 
open Godot
 
type ActorFs() =
    inherit RigidBody2D()
 
    override this._Ready() = 
        GD.Print("Hello from F#!")