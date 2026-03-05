extends Node

var level_container: Node = null
var game_control: Control = null
var last_scene: String = ""
var current_scene: Node = null

var current_level_path: String = ""

func register_level_container(n: Node):
	level_container = n

func register_game_control(g: Control):
	game_control = g

func current_scene_register(_nod: Node):
	if level_container.get_child_count() > 0:
		current_scene = level_container.get_child(level_container.get_child_count() - 1)
	else:
		push_error(" There are no current Children to count")
	

func load_level(scene_path: String):
	if level_container == null:
		push_error("SceneSwitcher: level_container is null (not registered).")
		return
	
	for child in level_container.get_children():
		child.queue_free()
		
	var packed:= load(scene_path) as PackedScene
	if packed == null:
		push_error("SceneSwitcher: Could not load PackedScene at: " + scene_path)
		return
	
	var level := packed.instantiate()
	level_container.call_deferred("add_child", level)
	current_level_path = scene_path


func load_current_scene():
	load_level(current_level_path)
