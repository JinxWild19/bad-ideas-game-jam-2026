extends Node2D
class_name Flowers

@export_category("Watering Abbilities")
@export var watering = get_parent().get_parent().get_node("Memory")

func _ready():
	watering.watering.connect(grow)
	watering.stopped_watering.connect(grow)

func grow():
	if await watering._on_water_button_button_down() == true:
		print("Watering")
	elif await watering._on_water_button_button_up() == true:
		print("Stopped watering")
