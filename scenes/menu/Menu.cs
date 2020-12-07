using Godot;

public class Menu : Base
{
    public void OnStartPressed()
    {
        switchTo("res://scenes/game/Diner.tscn");
    }

    public void OnAboutPressed()
    {
        switchTo("res://scenes/about/About.tscn");
    }
}
