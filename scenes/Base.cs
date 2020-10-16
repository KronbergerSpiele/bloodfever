using Godot;
using System;

public class Base : Node2D
{
    public KSPage Page;

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
        Page = new KSPage(GetNode("CanvasLayer/Page"), Global().LastSceneSnapshot);
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
                GetTree().GetRoot().RemoveChild(Global().LastSceneLayer);
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
        GD.Print(oldHeight, ",", oldWidth, ",", oldTex.HasAlpha(), scalex, scaley);

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
        GD.Print(tmp.Scale);
        layer.AddChild(tmp);

        GetTree().GetRoot().AddChild(layer);

        Global().LastSceneLayer = layer;
        Global().LastScene = this;
    }
}
