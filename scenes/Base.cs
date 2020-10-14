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

    public override void _Ready()
    {
        base._Ready();
        GD.Print("base ready");
        Page = new KSPage(GetNode("Page"), Global().LastSceneSnapshot);
    }

    public void switchTo(String scene)
    {
        var img = GetViewport().GetTexture().GetData();
        img.FlipY();
        var tex = new ImageTexture();
        tex.CreateFromImage(img);
        Global().LastSceneSnapshot = tex;
        GetTree().ChangeScene(scene);
    }
}
