using Godot;

[Tool]
public class SpeechBase : TextureButton
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
        if (HasNode("Label"))
            return GetNode<Label>("Label");
        return null;
    }
}
