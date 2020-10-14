using Godot;
using System;
using System.Collections.Generic;

public class Actor : RigidBody2D, IComparable
{
    [Export]
    private int hitpoints = 100;

    [Export]
    private int damage = 2;

    protected SortedSet<Actor> touchingBodies = new SortedSet<Actor>();

    public int CompareTo(object obj)
    {
        if (obj == null)
            return 1;

        if (obj is Actor otherActor)
            return GetInstanceId().CompareTo(otherActor.GetInstanceId());
        else
            throw new ArgumentException("Object is not a Actor");
    }

    public AnimatedSprite _AnimatedSprite()
    {
        return GetNode<AnimatedSprite>("AnimatedSprite");
    }

    public override void _Ready()
    {
        base._Ready();
        Inertia = float.PositiveInfinity;
        GetNode<AnimatedSprite>("AnimatedSprite").Play("R000");
    }

    public override void _Process(float delta)
    {
        base._Process(delta);
        r315HandleGraphics();
        r315HandleCollisions();
    }

    public virtual String r315Prefix()
    {
        return "";
    }

    public virtual Boolean r315HonorRotation()
    {
        return true;
    }

    public virtual void r315HandleCollisions() { }

    public virtual void r315HandleGraphics()
    {
        var vel = LinearVelocity.Length();
        ZIndex = (int)Position.y;
        if (vel < 1.0)
        {
            _AnimatedSprite().Stop();
        }
        else
        {
            if (!_AnimatedSprite().Playing)
                _AnimatedSprite().Play();
            var rotation = LinearVelocity.Normalized().Angle();
            var nextAnimation = r315Prefix();
            if (r315HonorRotation())
                nextAnimation += r315OrientationForRotation(rotation);
            if (_AnimatedSprite().Animation != nextAnimation)
                _AnimatedSprite().Play(nextAnimation);
        }

    }

    public virtual String r315OrientationForRotation(float rotation)
    {
        if (rotation <= -Math.PI * 7 / 8)
            return "R180";

        if (rotation > -Math.PI * 7 / 8 && rotation <= -Math.PI * 5 / 8)
            return "R135";

        if (rotation > -Math.PI * 5 / 8 && rotation <= -Math.PI * 3 / 8)
            return "R090";

        if (rotation > -Math.PI * 3 / 8 && rotation <= -Math.PI * 1 / 8)
            return "R045";

        if (rotation > -Math.PI * 1 / 8 && rotation <= Math.PI * 1 / 8)
            return "R000";

        if (rotation > Math.PI * 1 / 8 && rotation <= Math.PI * 3 / 8)
            return "R315";

        if (rotation > Math.PI * 3 / 8 && rotation <= Math.PI * 5 / 8)
            return "R270";

        if (rotation > Math.PI * 5 / 8 && rotation <= Math.PI * 7 / 8)
            return "R225";

        if (rotation > Math.PI * 7 / 8)
            return "R180";

        return "R000";
    }

    public virtual void onBodyEntered(Node body)
    {
        if (body is Actor actor)
            touchingBodies.Add(actor);
    }

    public virtual void onBodyExcited(Node body)
    {
        if (body is Actor actor)
            touchingBodies.Remove(actor);
    }
}
