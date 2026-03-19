extends Node2D
class_name Memory_Flowers

@export_category("Base Components")
@export var flower_selector: Node2D
@export var flower_label: RichTextLabel
@export var watering_can: Node2D

signal watering
signal stopped_watering

func _ready():
	watering_can.particles.emitting = false

func _on_water_button_button_down():
	watering_can.wateringcan_animsprite.play("pour")
	await watering_can.wateringcan_animsprite.animation_finished
	watering_can.particles.emitting = true
	emit_signal("watering")


func _on_water_button_button_up():
	watering_can.wateringcan_animsprite.play("stop_pouring")
	watering_can.particles.emitting = false
	emit_signal("stopped_watering")
