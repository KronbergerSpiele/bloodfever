using Godot;
using System;

[Tool]
public class SpeechButton : TextureButton
{
    [Export]
    public string label
    {
        get
        {
            if (LI() != null)
                return LI().Text;
            else return "";
        }
        set
        {
            if (LI() != null)
                LI().Text = value;
        }
    }

    private Label LI()
    {
        return GetNode<Label>("Label");
    }
}
