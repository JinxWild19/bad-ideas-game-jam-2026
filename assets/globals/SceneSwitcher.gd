extends Node

## UI

var level_container_UI: Node = null
var last_scene_UI: String = ""
var current_scene_UI: Node = null

var current_level_path_UI: String = ""

func register_level_container_UI(n: Node) -> void:
	level_container_UI = n

func current_scene_register_UI(_node: Node):
	if level_container_UI.get_child_count() > 0:
		current_scene_UI = level_container_UI.get_child(level_container_UI.get_child_count() - 1)
	else:
		push_error("🚸 There are no current Children to count")
	

func load_level_UI(scene_path: String) -> void:
	if level_container_UI == null:
		push_error("SceneSwitcher: level_container_UI is null (not registered).")
		return
	
	for child in level_container_UI.get_children():
		child.queue_free()
	
	var packed := load(scene_path) as PackedScene
	if packed == null:
		push_error("SceneSwitcher : Could not load PackedScene at: ", scene_path)
		return
	
	var level := packed.instantiate()
	level_container_UI.call_deferred("add_child", level)
	current_level_path_UI = scene_path

func load_current_scene_UI():
	load_level_2D(current_level_path_UI)

## 2D


var level_container_2D: Node = null
var last_scene_2D: String = ""
var current_scene_2D: Node = null

var current_level_path_2D: String = ""

func register_level_container_2D(n: Node) -> void:
	level_container_2D = n

func current_scene_register_2D(_node: Node):
	if level_container_2D.get_child_count() > 0:
		current_scene_2D = level_container_2D.get_child(level_container_2D.get_child_count() - 1)
	else:
		push_error("🚸 There are no current Children to count")
	

func load_level_2D(scene_path: String) -> void:
	if level_container_2D == null:
		push_error("SceneSwitcher: level_container is null (not registered).")
		return
	
	for child in level_container_2D.get_children():
		child.queue_free()
	
	var packed := load(scene_path) as PackedScene
	if packed == null:
		push_error("SceneSwitcher : Could not load PackedScene at: ", scene_path)
		return
	
	var level := packed.instantiate()
	level_container_2D.call_deferred("add_child", level)
	current_level_path_2D = scene_path

func load_current_scene_2D():
	load_level_2D(current_level_path_2D)
