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

    public Global Global()
    {
        return GetNode<Global>("/root/Global");
    }

    public override void _Ready()
    {
        LastScene().Texture = Global().LastSceneSnapshot;
        LastScene().Scale = new Vector2(1, 1);
        LastSceneAnimation().Play("disappear");
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
