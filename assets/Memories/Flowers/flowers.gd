extends Node2D
class_name Flowers

@export_category("Watering Abbilities")
@export var watering: Memory_Flowers
func _ready():
	watering.watering.connect(grow)
	watering.stopped_watering.connect(grow)

func grow():
	if await watering._on_water_button_button_down() == true:
		pass
