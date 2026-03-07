extends Resource
class_name PlayerStats

enum Buffable_Stats{
	MAX_HEALTH,
	ATTACK,
	DEFENCE,
	HEAL,
}

const STAT_CURVES: Dictionary[Buffable_Stats, Curve]= {
	Buffable_Stats.MAX_HEALTH: preload("uid://cg0sxg5423r8u"),
	Buffable_Stats.ATTACK: preload("uid://4aspiklqojes"),
	Buffable_Stats.DEFENCE: preload("uid://l5koqrylry20"),
	Buffable_Stats.HEAL: preload("uid://cu6vwyecmxxwy"),
}

@export_category("Base Stats")
@export var base_attack: float
@export var base_defence: float
@export var base_heal: float
@export var base_max_health: float
@export var experience: int = 0: set = _on_experience_set

@export_category("Modifires")
@export var attack_modifier: float
@export var defence_modifire: float
@export var heal_modifier: float

var current_attack: float
var current_defence: float
var current_heal: float
var current_max_health: float

var stat_buffs: Array[PlayerStatBuff]

var level: int:
	get(): return floor(max(1.0, sqrt(experience / 100.0) + 0.5))

var health: float = 0.0: set = _on_health_set

signal player_health_depleated
signal player_health_changed(cur_health: float, max_health: float)

func _init():
	setup_stats.call_deferred()

func setup_stats():
	recalculate_stats()
	health = current_max_health

func add_buff(buff: PlayerStatBuff):
	stat_buffs.append(buff)
	recalculate_stats.call_deferred()

func remove_buff(buff: PlayerStatBuff):
	stat_buffs.erase(buff)
	recalculate_stats.call_deferred()

func recalculate_stats():
	var stat_multipliers: Dictionary = {} # Amount to multiply included stas by
	var stat_addends: Dictionary = {} # Amount to add to included stats
	for buff in stat_buffs:
		var stat_name: String = Buffable_Stats.keys()[buff.stat].to_lower()
		match buff.buff_type:
			PlayerStatBuff.BuffType.ADD:
				if not stat_addends.has(stat_name):
					stat_addends[stat_name] = 0.0
				stat_addends[stat_name] += buff.buff_amount
			
			PlayerStatBuff.BuffType.MULTIPLY:
				if not stat_multipliers.has(stat_name):
					stat_multipliers[stat_name] = 1.0
				stat_multipliers[stat_name] += buff.buff_amount
				
				if stat_multipliers[stat_name] < 0.0:
					stat_multipliers[stat_name] = 0.0
	
	var stat_sample_pos: float = (float(level) / 100.0) - 0.01
	current_max_health = base_max_health * STAT_CURVES[Buffable_Stats.MAX_HEALTH].sample(stat_sample_pos)
	current_attack = base_attack * STAT_CURVES[Buffable_Stats.ATTACK].sample(stat_sample_pos)
	current_defence = base_defence * STAT_CURVES[Buffable_Stats.DEFENCE].sample(stat_sample_pos)
	current_heal = base_heal * STAT_CURVES[Buffable_Stats.HEAL].sample(stat_sample_pos)
	
	for stat_name in stat_multipliers:
		var cur_property_name: String = str("current_" + stat_name)
		set(cur_property_name, get(cur_property_name) * stat_multipliers[stat_name])
	
	for stat_name in stat_addends:
		var cur_property_name: String = str("current_" + stat_name)
		set(cur_property_name, get(cur_property_name) + stat_multipliers[stat_name])


func _on_health_set(new_value: float):
	health = clampf(new_value, 0.0, current_max_health)
	player_health_changed.emit(health, current_max_health)
	if health <= 0.0:
		player_health_depleated.emit()

func _on_experience_set(new_value: int):
	var old_level: int = level
	experience = new_value
	
	if not old_level == level:
		recalculate_stats()


#func regain_health():
	#heal + heal_modifier == health
	#print(health)
#
#func attack_amount():
	#attack + attack_modifier == attack
	#print(attack)
#
#func defence_amount():
	#attack - (defence + defence_modifire) == health
	#print(health)
