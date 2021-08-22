using Godot;

public class About : Base
{
    public void OnAboutPressed()
    {
        SwitchTo("res://scenes/menu/Menu.tscn");
    }
}
