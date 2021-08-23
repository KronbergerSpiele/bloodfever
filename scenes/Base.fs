namespace BloodFeverFs.Scene

open BloodFeverFs
open KSGodot
open KSGodotUtils
open Godot
open System

type Base() =
    inherit Node2D()

    member val Page: Option<Page> = None with get, set

    member val private random = Random()
    member this.NextRandom() = this.random.Next()

    member this.Global() = this.getNode<Global> ("/root/Global")

    override this._EnterTree() =
        base._EnterTree ()
        this.Page <- Some(Page(this.getNode ("CanvasLayer/Page"), this.Global().LastSceneSnapshot))

    member val private ticks = 0 with get, set

    override this._Process(delta) =
        base._Process (delta)

        if this.ticks < 2 then
            this.ticks <- this.ticks + 1
        else if this.Global().LastScene <> Some(this :> Node2D) then
            match this.Global().LastSceneLayer with
            | None -> ()
            | Some layer ->
                do
                    this.GetTree().Root.RemoveChild(layer)
                    this.Global().LastSceneLayer <- None


    member this.SwitchTo(scene: string) =
        let oldTex = this.GetViewport().GetTexture()
        let oldWidth = float32 (oldTex.GetWidth())
        let oldHeight = float32 (oldTex.GetHeight())
        let scalex = 480.0f / oldWidth
        let scaley = 320.0f / oldHeight

        let img = oldTex.GetData()
        img.FlipY()
        let tex = new ImageTexture()
        tex.CreateFromImage(img, 0u)

        this.Global().LastSceneSnapshot <- Some tex
        let err = this.GetTree().ChangeScene(scene)

        let layer = new CanvasLayer()
        layer.Layer <- 99

        let tmp = new Sprite()
        tmp.Texture <- tex
        tmp.Position <- Vector2(240f, 160f)
        tmp.Scale <- Vector2(scalex, scaley)
        layer.AddChild(tmp)

        this.GetTree().Root.AddChild(layer)

        this.Global().LastSceneLayer <- Some layer
        this.Global().LastScene <- Some(this :> Node2D)
