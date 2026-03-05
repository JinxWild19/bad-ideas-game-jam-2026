extends Node2D

@export var starting_level_path: String = "uid://djf4dccosrv5n" #Main Menu
@onready var level_container: Node2D = %LevelContainer
@onready var game_control: Control = %GameControl
@onready var current_scene: Node = null

func _ready():
	SceneSwitcher.register_level_container(level_container)
	SceneSwitcher.register_game_control(game_control)
	SceneSwitcher.current_scene_register(current_scene)
	TransitionTSCN.transition()
	await TransitionTSCN.on_transition_finished
	SceneSwitcher.load_level(starting_level_path)
	
