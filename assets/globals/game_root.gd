extends Node2D

@export var starting_level_path: String = "uid://djf4dccosrv5n" #Main Menu
@onready var level_container_2D: Node2D = %LevelContainer
@onready var GUIContainer: Control = %GameControl
@onready var current_scene_2D: Node2D = null
@onready var current_scene_UI: Control = null

func _ready():
	SceneSwitcher.register_level_container_2D(level_container_2D)
	SceneSwitcher.register_level_container_UI(GUIContainer)
	SceneSwitcher.current_scene_register_2D(current_scene_2D)
	SceneSwitcher.current_scene_register_UI(current_scene_UI)
	TransitionTSCN.transition()
	await TransitionTSCN.on_transition_finished
	SceneSwitcher.load_level_UI(starting_level_path)
	SceneSwitcher.load_level_2D("uid://63o0y2jwejbm") #empty
	
