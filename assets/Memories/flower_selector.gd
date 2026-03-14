extends Node2D

@export_category("Base Components")
@export var flower_selector: Node2D
@export var flower_label: RichTextLabel

var flower_keys: Array = []
var current_flower_index: int = 0
var current_preview: Node2D = null

var selected_flower_enum: int: #may not need
	get:
		return flower_keys[current_flower_index]

func _ready():
	set_flower_keys()
	update_sprite_scene()

func update_sprite_scene():
	var current_flower_enum = flower_keys[current_flower_index]
	var scene_path = FlowerDatabase.FLOWER_SCENE_PATHS[current_flower_enum]
	var packed_scene = load(scene_path)
	
	if current_preview:
		#Probably going to cause problems with the flowers
		current_preview.queue_free()
	
	if packed_scene:
		current_preview = packed_scene.instantiate()
		flower_selector.add_child(current_preview)
	
	var flower_name = FlowerDatabase.FLOWER_NAMES[current_flower_enum]
	flower_label.text = flower_name
	

func set_flower_keys():
	flower_keys = FlowerDatabase.FLOWER_SCENE_PATHS.keys()



func _on_left_button_pressed():
	current_flower_index = wrap_index(current_flower_index - 1, flower_keys.size())
	update_sprite_scene()


func _on_right_button_pressed():
	current_flower_index = wrap_index(current_flower_index + 1, flower_keys.size())
	update_sprite_scene()
	
func wrap_index(i: int, size: int) -> int:
	return (i + size) % size
