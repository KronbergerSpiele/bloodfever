namespace BloodFeverFs

open System
open Godot
 
type ActorFs() =
    inherit RigidBody2D()
 
     override x.Equals(yobj) =
        match yobj with
            | :? ActorFs as y -> (x.GetInstanceId() = y.GetInstanceId())
            | _ -> false

    override x.GetHashCode() = System.Convert.ToInt32(x.GetInstanceId())

    interface System.IComparable with
      member x.CompareTo yobj =
          match yobj with
              | :? ActorFs as y -> x.GetInstanceId().CompareTo(y.GetInstanceId())
              | _ -> invalidArg "yobj" "cannot compare values of different types"

    override this._Ready() = 
        GD.Print("Hello from F#2!")