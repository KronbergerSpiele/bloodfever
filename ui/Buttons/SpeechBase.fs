namespace BloodFeverFs.UI

open Godot
open KSGodotUtils

[<Tool>]
type SpeechBase() =
    inherit TextureButton()

    member this.LI(): Option<Label> =
        if this.hasNode("Label") then
            Some (this.getNode<Label>("Label"))
        else
            None

    [<Export>]
    member this.label
        with get () = 
            match this.LI() with
            | Some label -> label.Text
            | None -> ""
        and set (value) =
            match this.LI() with
            | Some label -> label.Text <- value
            | None -> ()


