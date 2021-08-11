namespace KSUtil

open Godot
open System

[<Flags>]
type ActorType =
    | None = 0x0
    | Player = 0x1
    | Goal = 0x2
    | Enemy = 0x4