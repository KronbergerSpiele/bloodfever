using Godot;
using System;

public class Pause : Base
{
    public Node2D Overlay()
    {
        return GetNode<Node2D>("Overlay");
    }

    public override void _EnterTree()
    {
        Overlay().Visible = false;
    }

    public override void _Ready()
    {
        Overlay().Visible = false;

    }

    public void OnPauseButtonPressed()
    {
        GetTree().SetInputAsHandled();
    }
}
