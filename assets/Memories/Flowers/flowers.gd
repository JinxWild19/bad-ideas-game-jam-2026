extends Node2D
class_name Flowers

@export var growth_stage_timer: float = 10.0

@onready var water = get_parent().get_node("/root/GameRoot/LevelContainer/Memory")

func _ready():
	water.watering.connect(grow)
	water.stopped_watering.connect(grow)

func grow():
	if await water._on_water_button_button_down() == true:
		print("Watering")
	elif await water._on_water_button_button_up() == true:
		print("Stopped watering")
