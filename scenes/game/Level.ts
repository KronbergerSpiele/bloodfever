import Actor from "../../actors/Actor";
import Base from "../Base";

export default class Level extends Base {
  ZombieTemplate: PackedScene<Actor> = load("res://actors/zombie/Zombie.tscn");

  get UI() {
    return this.get_node("UI");
  }

  get Draco() {
    return this.get_node("actors/Draco");
  }

  get Actors() {
    return this.get_node("actors");
  }

  get Stick() {
    return this.get_node("UI/Stick");
  }

  get spawnLocation() {
    return this.get_node("SpawnPath/SpawnLocation");
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
