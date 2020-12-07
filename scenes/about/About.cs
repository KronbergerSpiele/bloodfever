using Godot;

public class About : Base
{
    public void OnAboutPressed()
    {
        switchTo("res://scenes/menu/Menu.tscn");
    }
}
