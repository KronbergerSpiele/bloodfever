import { Actor } from "actors/Actor";
import { Stick } from "ksgodot/stick/Stick";
import { Base } from "scenes/Base";

export class Level extends Base {
  ZombieTemplate: PackedScene<Actor> = load("res://actors/zombie/Zombie.tscn");

  get UI() {
    return this.get_node_unsafe<CanvasLayer>("UI");
  }

  get Draco() {
    return this.get_node_unsafe<Actor>("actors/Draco");
  }

  get Actors() {
    return this.get_node_unsafe<Node>("actors");
  }

  get Stick() {
    return this.get_node_unsafe<Stick>("UI/Stick");
  }

  get spawnLocation() {
    return this.get_node_unsafe<PathFollow2D>("SpawnPath/SpawnLocation");
  }

  _process() {
    this.Draco.linear_velocity = this.Stick.output.mul(2);
  }

  onSpawnTimer() {
    this.spawnLocation.unit_offset = this.nextRandom();
    const mobInstance = this.ZombieTemplate.instance();
    this.Actors.add_child(mobInstance);
    mobInstance.position = this.spawnLocation.position;
  }
}
