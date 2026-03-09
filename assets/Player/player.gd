extends Node2D

@export_category("Buttons")
@export var attack_button: Button
@export var defend_button: Button
@export var heal_button: Button

@export_category("Enemy")
@export var enemy: Node2D

@export_category("Progress Bars")
@export var health_progress_bar: ProgressBar

@export_category("Components")
@export var stats: PlayerStats

@export_category("Memories")
@export var memory1: PackedScene
@export var memory2: PackedScene

@onready var memories: Array = [memory1, memory2]
#@onready var memory_chance: Array[float] = [10, 10,]

signal player_finished_turn

func _ready():
	stats.player_health_changed.connect(health_bar)
	stats.player_health_depleated.connect(player_dead)

func health_bar(health: float, max_health: float):
	health_progress_bar.max_value = max_health
	health_progress_bar.value = health
	print("Player ", health," ", max_health)

func memory_randomizer():
	var random_index = randi() % memories.size()
	var selected_memory = memories[random_index]
	return selected_memory

func player_dead():
	var selected_memory = memory_randomizer()
	var memory_chosen = selected_memory.resource_path
	print("This is the selected memory < ", memory_chosen, " > This is where it ends.")
	TransitionTSCN.transition()
	await TransitionTSCN.on_transition_finished
	SceneSwitcher.load_level_2D("%s" %memory_chosen)


func _on_attack_button_pressed():
	enemy.stats.health -= stats.current_attack
	print("Enemy health = ", enemy.stats.health)
	player_finished_turn.emit()


func _on_defend_button_pressed():
	enemy.stats.current_attack -= stats.current_defence
	print("Player defened for %s" % stats.current_defence)
	player_finished_turn.emit()


func _on_heal_button_pressed():
	stats.health += stats.current_heal
	print("Player healed for = ", stats.current_heal)
	player_finished_turn.emit()
