using Godot;

public class Pause : Node2D
{
    public Node2D Overlay()
    {
        return GetNode<Node2D>("Overlay");
    }

    public override void _EnterTree()
    {
        base._EnterTree();
        Overlay().Visible = false;
    }

    public override void _Ready()
    {
        base._Ready();
        Overlay().Visible = false;
    }

    public void OnPauseButtonPressed()
    {
        GetTree().SetInputAsHandled();
    }
}
