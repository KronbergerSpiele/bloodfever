using Godot;
using System;

public class Level : Node2D
{

    public override void _Ready()
    {
        GD.Print("level ready 5");
    }

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

    public override void _Process(float delta)
    {
        var output = (Vector2)Stick().Get("output");
        Draco().LinearVelocity = output * 2;
    }
}
