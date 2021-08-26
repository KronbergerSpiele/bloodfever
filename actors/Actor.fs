namespace BloodFeverFs.Actors

open BloodFeverFs.Audio

open Godot
open System
open KSGodot
open KSGodotUtils

[<Flags>]
type ActorType =
    | None = 0x0
    | Player = 0x1
    | Goal = 0x2
    | Enemy = 0x4

[<Flags>]
type DamageMode =
    | None = 0x0
    | Deals = 0x1
    | Takes = 0x2

type Actor() =
    inherit RigidBody2D()

    [<ExportFlagsEnum(typedefof<ActorType>)>]
    member val actorType = ActorType.None with get, set

    [<Export>]
    member val hitpoints = 100 with get, set

    [<Export>]
    member val hitSound: AudioStream = null with get, set

    [<Export>]
    member val damage = 2 with get, set

    [<ExportFlagsEnum(typedefof<ActorType>)>]
    member val damageTakeFrom = ActorType.None with get, set

    [<ExportFlagsEnum(typedefof<DamageMode>)>]
    member val damageMode = DamageMode.None with get, set

    member this.Sprite() =
        this.getNode<AnimatedSprite> ("AnimatedSprite")

    member this.Animations() =
        this.getNode<AnimationPlayer> ("AnimationPlayer")

    member this.Audio() =
        this.getNode<LocalAudio> ("AudioPlayer")

    override this.Equals(yobj) =
        match yobj with
        | :? Actor as y -> (this.GetInstanceId() = y.GetInstanceId())
        | _ -> false

    override x.GetHashCode() =
        System.Convert.ToInt32(x.GetInstanceId())

    interface System.IComparable with
        member x.CompareTo yobj =
            match yobj with
            | :? Actor as y -> x.GetInstanceId().CompareTo(y.GetInstanceId())
            | _ -> invalidArg "yobj" "cannot compare values of different types"

    override this._Ready() =
        base._Ready ()
        this.Inertia <- Single.PositiveInfinity
        this.Sprite().Play "R000"

    override this._Process delta =
        base._Process delta
        this.R315HandleCollisions()
        this.R315HandleGraphics()

    abstract R315Prefix : unit -> string
    default this.R315Prefix() = ""

    abstract R315HonorRotation : unit -> bool
    default this.R315HonorRotation() = true

    member this.CollidingActors =
        [ for body in this.GetCollidingBodies() do
              match body with
              | :? Actor as actor -> yield actor
              | _ -> () ]

    abstract R315HandleCollisions : unit -> unit

    default this.R315HandleCollisions() =
        let potentiallyDealDamage (origin: Actor, target: Actor) =
            if (target.damageTakeFrom &&& origin.actorType)
               <> ActorType.None then
                target.ApplyDamage(origin.damage, origin.actorType)

        if (this.damageMode &&& DamageMode.Deals)
           <> DamageMode.None then
            for other in this.CollidingActors do
                potentiallyDealDamage (this, other)

        if (this.damageMode &&& DamageMode.Takes)
           <> DamageMode.None then
            for other in this.CollidingActors do
                potentiallyDealDamage (other, this)

    abstract R315HandleGraphics : unit -> unit

    default this.R315HandleGraphics() =
        let sprite = this.Sprite()
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

    abstract ApplyDamage : int * ActorType -> unit

    default this.ApplyDamage(amount, from) =
        this.hitpoints <- this.hitpoints - amount

        this.Animations().Play("Hit")

        if not (isNull this.hitSound) then
            this.Audio().Stop()
            this.Audio().Stream <- this.hitSound
            this.Audio().Play()

        if this.hitpoints <= 0 then
            this.QueueFree()
