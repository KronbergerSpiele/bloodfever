using Godot;

public class Menu : Base
{
    public void OnStartPressed()
    {
        SwitchTo("res://scenes/game/Diner.tscn");
    }

    public void OnAboutPressed()
    {
        SwitchTo("res://scenes/about/About.tscn");
    }
}
