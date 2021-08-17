using Godot;
using System;
using KSGodot;

public class Base : Node2D
{
    public Page Page;

    public Global Global()
    {
        return GetNode<Global>("/root/Global");
    }

    protected Random _random = new Random();

    protected float RandRange(float min, float max)
    {
        return (float)_random.NextDouble() * (max - min) + min;
    }

    public override void _EnterTree()
    {
        base._EnterTree();
        Page = new Page(GetNode("CanvasLayer/Page"), Global().LastSceneSnapshot);
    }

    protected int ticks = 0;

    public override void _Process(float delta)
    {
        base._Process(delta);
        // clear the old overlaying image on the second process
        // to allow rendering of everything on the first
        if (++ticks >= 2)
        {
            if (Global().LastScene != this && Global().LastSceneLayer != null)
            {
                GetTree().Root.RemoveChild(Global().LastSceneLayer);
                Global().LastSceneLayer = null;
            }
        }
    }

    public void switchTo(String scene)
    {
        var oldTex = GetViewport().GetTexture();
        var oldWidth = oldTex.GetWidth();
        var oldHeight = oldTex.GetHeight();
        var scalex = 480.0f / oldWidth;
        var scaley = 320.0f / oldHeight;

        var img = oldTex.GetData();
        img.FlipY();
        var tex = new ImageTexture();
        tex.CreateFromImage(img, 0);

        Global().LastSceneSnapshot = tex;
        GetTree().ChangeScene(scene);

        var layer = new CanvasLayer();
        layer.Layer = 99;

        var tmp = new Sprite();
        tmp.Texture = tex;
        tmp.Position = new Vector2(240, 160);
        tmp.Scale = new Vector2(scalex, scaley);
        layer.AddChild(tmp);

        GetTree().Root.AddChild(layer);

        Global().LastSceneLayer = layer;
        Global().LastScene = this;
    }
}
