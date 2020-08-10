using Godot;
using System;

public class Level : Base
{
    public KSStick Stick;

    public Node UI()
    {
        return GetNode("UI");
    }

    public Actor Draco()
    {
        return GetNode<Draco>("actors/Draco");
    }

    public override void _Ready()
    {
        Stick = new KSStick(
            GetNode("UI/Stick")
        );
    }

    public override void _Process(float delta)
    {
        Draco().LinearVelocity = Stick.Output() * 2;
    }
}
