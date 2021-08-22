using Godot;

public class Loading : Base
{
    public override void _Ready()
    {
        base._Ready();
        GetNode<Timer>("Timer").Start();
    }

    public void OnTimerTimeout()
    {
        SwitchTo("res://scenes/menu/Menu.tscn");
    }
}
