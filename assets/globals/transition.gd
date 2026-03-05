extends Control

@export var color_rect: ColorRect
@export var color_animation_player: AnimationPlayer

signal on_transition_finished

func _ready():
	color_rect.visible = false
	color_animation_player.animation_finished.connect(_on_animation_finished)

func transition():
	color_rect.visible = true
	color_animation_player.play("fade_to_color")

func _on_animation_finished(anim_name):
	if anim_name == "fade_to_color":
		on_transition_finished.emit()
		color_animation_player.play("color_to_fade")
	elif anim_name == "color_to_fade":
		color_rect.visible = false
