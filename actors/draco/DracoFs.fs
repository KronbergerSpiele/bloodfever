namespace BloodFeverFs

open Godot

type DracoFs() =
    inherit ActorFs()

    //TODO: move to actor and data-drive so coffin takes from zombies
    override this.R315HandleCollisions() =
        for other in this.TouchingBodies do
            GD.Print(other,other.takeDamageFrom,this.actorType)
            if (other.takeDamageFrom &&& this.actorType) <> 0 then
                other.hitpoints <- other.hitpoints - this.damage
                if other.hitpoints <= 0 then
                    other.QueueFree()