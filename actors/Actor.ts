import { ActorEquality } from "actors/ActorEquality";

enum ActorType {
  None = 0x0,
  Player = 0x1,
  Goal = 0x2,
  Enemy = 0x4,
}

enum DamageMode {
  None = 0x0,
  Deals = 0x1,
  Takes = 0x2,
}

export class Actor extends ActorEquality {
  @export_flags("Player", "Goal", "Enemy")
  public actorType: ActorType = ActorType.None;

  @exports
  public hitpoints: int = 100;

  @exports
  public damage: int = 2;

  @export_flags("Player", "Goal", "Enemy")
  public damageTakenFrom: ActorType = ActorType.None;

  @export_flags("Deals", "Takes")
  public damageMode: DamageMode = DamageMode.None;

  get isActivelyHandlingDamage() {
    return !!this.damageMode;
  }

  // @exports
  // public hitSound: AudioStream | null = null;

  public get Sprite() {
    return this.get_node("AnimatedSprite");
  }

  public get Animations() {
    return this.get_node("AnimationPlayer");
  }

  // public get Audio() {
  //   return this.get_node("AudioPlayer");
  // }

  public _ready() {
    this.inertia = INF;
    this.Sprite.play("R000");
    this.contact_monitor = this.isActivelyHandlingDamage;
  }

  _process() {
    this.r315HandleGraphics();
  }

  _physics_process(delta: float) {
    this.r315HandleCollisions();
  }

  public get r315Prefix() {
    return "";
  }

  public get r315HonorRotation() {
    return true;
  }

  public r315HandleGraphics() {
    const sprite = this.Sprite;
    const vel = this.linear_velocity.length();
    this.z_index = this.position.y;

    if (vel < 1) {
      return sprite.stop();
    }

    if (!sprite.playing) {
      sprite.play();
    }

    const nextAnimation = this.r315HonorRotation
      ? this.r315Prefix + this.R315OrientationForRotation
      : this.r315Prefix;

    if (nextAnimation !== sprite.animation) {
      sprite.play(nextAnimation);
    }
  }

  public get R315OrientationForRotation(): string {
    const rot = this.linear_velocity.normalized().angle();

    if (rot <= (-PI * 7) / 8) {
      return "R180";
    } else if (rot > (-PI * 7) / 8 && rot <= (-PI * 5) / 8) {
      return "R135";
    } else if (rot > (-PI * 5) / 8 && rot <= (-PI * 3) / 8) {
      return "R090";
    } else if (rot > (-PI * 3) / 8 && rot <= (-PI * 1) / 8) {
      return "R045";
    } else if (rot > (-PI * 1) / 8 && rot <= (PI * 1) / 8) {
      return "R000";
    } else if (rot > (PI * 1) / 8 && rot <= (PI * 3) / 8) {
      return "R315";
    } else if (rot > (PI * 3) / 8 && rot <= (PI * 5) / 8) {
      return "R270";
    } else if (rot > (PI * 5) / 8 && rot <= (PI * 7) / 8) {
      return "R225";
    } else if (rot > (PI * 7) / 8) {
      return "R180";
    } else {
      return "R000";
    }
  }

  public r315HandleCollisions() {
    if (!this.isActivelyHandlingDamage) {
      return;
    }
    for (let other of this.get_colliding_bodies()) {
      if (!(other instanceof ActorEquality)) {
        continue;
      }
      other = other as Actor;
      if (this.damageMode & DamageMode.Deals) {
        this.potentiallyDealDamage(this, other);
      }
      if (this.damageMode & DamageMode.Takes) {
        this.potentiallyDealDamage(other, this);
      }
    }
  }

  private potentiallyDealDamage(origin: Actor, target: Actor) {
    if (target.damageTakenFrom & origin.actorType) {
      target.applyDamage(origin.damage, origin.actorType);
    }
  }

  public applyDamage(amount: int, from: ActorType) {
    this.hitpoints -= amount;
    this.Animations.play("Hit");
    // if (this.hitSound) {
    //   this.Audio.play(this.hitSound, "hit")
    // }
    if (this.hitpoints <= 0) {
      this.queue_free();
    }
  }
}
