using Godot;
using System;

public class Base : Node2D
{
    public Sprite LastScene()
    {
        return GetNode<Sprite>("lastScene");
    }

    public AnimationPlayer LastSceneAnimation()
    {
        return GetNode<AnimationPlayer>("lastSceneAnimation");
    }

    public Node Global()
    {
        return GetNode("/root/Global");
    }

    public override void _Ready()
    {
        LastScene().Texture = Global().Get("lastSceneSnapshot") as Texture;
        LastScene().Scale = new Vector2(1, 1);
        LastSceneAnimation().Play("disappear");
        GD.Print(Global().Get("lastSceneSnapshot"));
    }

    public void switchTo(String scene)
    {
        var img = GetViewport().GetTexture().GetData();
        img.FlipY();
        var tex = new ImageTexture();
        tex.CreateFromImage(img);
        Global().Set("lastSceneSnapshot", tex);
        GetTree().ChangeScene(scene);
    }
}
