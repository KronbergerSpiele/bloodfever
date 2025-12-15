extends Node2D
class_name Lifebar

@export var health: float = 100.0
@export var healthIncome: float = 0.0

@onready var bar = $Bar

func _ready():
    # Ensure bar uses floatstep if possible, or just standard
    # TextureProgressBar takes float values, but we need to ensure max_value is correct
    pass

func _process(_delta: float):
    health += healthIncome
    healthIncome = 0
    bar.value = health

func set_max_health(max_hp: float):
    bar.max_value = max_hp
    bar.value = max_hp
