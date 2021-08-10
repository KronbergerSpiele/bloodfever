namespace BloodFeverFs

open Godot
open System
open KSUtil

[<Flags>]
type ActorType =
    | None = 0x0
    | Player = 0x1
    | Goal = 0x2
    | Enemy = 0x4

type ActorFs() =
    inherit RigidBody2D()

    [<Export>]
    let mutable hitpoints = 100

    [<Export>]
    let damage = 2

    [<ExportFlagsEnum(typedefof<ActorType>)>]
    let takeDamageFrom = 0

    member this._AnimatedSprite() =
        let path = new NodePath "AnimatedSprite"
        let node = this.GetNode path
        let sprite = node :?> AnimatedSprite
        sprite

    member this.TouchingBodies =
        new System.Collections.Generic.SortedSet<ActorFs>()

    override this.Equals(yobj) =
        match yobj with
        | :? ActorFs as y -> (this.GetInstanceId() = y.GetInstanceId())
        | _ -> false

    override x.GetHashCode() =
        System.Convert.ToInt32(x.GetInstanceId())

    interface System.IComparable with
        member x.CompareTo yobj =
            match yobj with
            | :? ActorFs as y -> x.GetInstanceId().CompareTo(y.GetInstanceId())
            | _ -> invalidArg "yobj" "cannot compare values of different types"

    override this._Ready() =
        base._Ready ()
        this.Inertia <- System.Single.PositiveInfinity
        this._AnimatedSprite().Play "R000"

    override this._Process delta =
        base._Process delta
        this.R315HandleCollisions()
        this.R315HandleGraphics()

    abstract R315Prefix : unit -> string
    default this.R315Prefix() = ""

    abstract R315HonorRotation : unit -> bool
    default this.R315HonorRotation() = true

    abstract R315HandleCollisions : unit -> unit
    default this.R315HandleCollisions() = ()

    abstract R315HandleGraphics : unit -> unit

    default this.R315HandleGraphics() =
        let sprite = this._AnimatedSprite ()
        let vel = this.LinearVelocity.Length()
        this.ZIndex <- int this.Position.y

        if vel < 1.0f then
            sprite.Stop()
        else
            if not (sprite.Playing) then
                sprite.Play()

            let nextAnimation =
                if this.R315HonorRotation() then
                    this.R315Prefix()
                    + (this.R315OrientationForRotation(this.LinearVelocity.Normalized().Angle()))
                else
                    this.R315Prefix()

            if nextAnimation <> sprite.Animation then
                sprite.Play nextAnimation


    abstract R315OrientationForRotation : float32 -> string

    default this.R315OrientationForRotation rot =
        let rotation = float rot

        if rotation <= -Math.PI * 7.0 / 8.0 then
            "R180"
        else if rotation > -Math.PI * 7.0 / 8.0
                && rotation <= -Math.PI * 5.0 / 8.0 then
            "R135"
        else if rotation > -Math.PI * 5.0 / 8.0
                && rotation <= -Math.PI * 3.0 / 8.0 then
            "R090"
        else if rotation > -Math.PI * 3.0 / 8.0
                && rotation <= -Math.PI * 1.0 / 8.0 then
            "R045"
        else if rotation > -Math.PI * 1.0 / 8.0
                && rotation <= Math.PI * 1.0 / 8.0 then
            "R000"
        else if rotation > Math.PI * 1.0 / 8.0
                && rotation <= Math.PI * 3.0 / 8.0 then
            "R315"
        else if rotation > Math.PI * 3.0 / 8.0
                && rotation <= Math.PI * 5.0 / 8.0 then
            "R270"
        else if rotation > Math.PI * 5.0 / 8.0
                && rotation <= Math.PI * 7.0 / 8.0 then
            "R225"
        else if rotation > Math.PI * 7.0 / 8.0 then
            "R180"
        else
            "R000"


    member this.onBodyEntered(body: Node) =
        match body with
        | :? ActorFs as actor -> this.TouchingBodies.Add actor
        | _ -> false

    member this.onBodyExcited(body: Node) =
        match body with
        | :? ActorFs as actor -> this.TouchingBodies.Remove actor
        | _ -> false
