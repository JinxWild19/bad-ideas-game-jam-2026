extends Resource
class_name EnemyStatBuff

enum BuffType{
	MULTIPLY,
	ADD,
}

@export var stat: EnemyStats.Buffable_Stats
@export var buff_amount: float
@export var buff_type: BuffType

func _init(_stat: EnemyStats.Buffable_Stats = EnemyStats.Buffable_Stats.MAX_HEALTH, _buff_amount: float = 1.0,
		_buff_type: EnemyStatBuff.BuffType = BuffType.MULTIPLY) -> void:
	stat = _stat
	buff_type = _buff_type
	buff_amount = _buff_amount
	#when wanting to use the above use StatBuff.new() and pass in the variables
