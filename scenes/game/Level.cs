using Godot;
using System;

public class Level : Base
{
    public Node UI()
    {
        return GetNode("UI");
    }

    public Node Stick()
    {
        return GetNode("UI/Stick");
    }

    public Actor Draco()
    {
        return GetNode<Draco>("actors/Draco");
    }

    public override void _Ready()
    {
    }

    public override void _Process(float delta)
    {
        var output = (Vector2)Stick().Get("output");
        Draco().LinearVelocity = output * 2;
    }
}
