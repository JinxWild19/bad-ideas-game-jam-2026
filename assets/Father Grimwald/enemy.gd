extends Node2D

@export_category("Player")
@export var player: Node2D

@export_category("Progress Bars")
@export var health_progress_bar: ProgressBar

@export_category("Components")
@export var stats: Stats

signal enemy_finished_turn

func _ready():
	stats.health_changed.connect(health_bar)
	player.player_finished_turn.connect()

#Fix the health not maching the stats health
#Upon implamenting and using the player attack button the health updates.
func health_bar(health: float, max_health: float):
	health_progress_bar.value = health
	health_progress_bar.max_value = max_health
	print("Enemy ", health," ", max_health)

func randomly_choose_action():
	pass


func _on_attack_button_pressed():
	player.stats.health -= stats.current_attack
	print("Player health = ", player.stats.health)
	enemy_finished_turn.emit()


func _on_defend_button_pressed():
	stats.current_defence -= player.stats.current_attack
	print("Enemy defened for %s" % stats.current_defence)
	enemy_finished_turn.emit()


func _on_heal_button_pressed():
	stats.current_heal += stats.health
	print("Enemy healed for = ", stats.current_heal)
	enemy_finished_turn.emit()
