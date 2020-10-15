using Godot;
using System;

public class Menu : Base
{
    public void OnStartPressed()
    {
        switchTo("res://scenes/game/Diner.tscn");
    }
}
