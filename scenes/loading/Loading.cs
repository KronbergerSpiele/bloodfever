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
        switchTo("res://scenes/menu/Menu.tscn");
    }
}
