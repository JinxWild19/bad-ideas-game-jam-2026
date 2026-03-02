extends Node

class_name Stats

@export var attack: int
@export var attack_modifier: int
@export var defence: int
@export var defence_modifire: int
@export var heal: int
@export var heal_modifier: int
@export var health: int
@export var max_health: int

func regain_health():
	heal + heal_modifier == health

func attack_amount():
	attack + attack_modifier == attack

func defence_amount():
	attack - (defence + defence_modifire) == health
