extends CanvasLayer



func _ready():
	SaveLoad.load_data()

func _on_play_button_pressed():
	TransitionTSCN.transition()
	await TransitionTSCN.on_transition_finished
	SceneSwitcher.load_level_UI("uid://cxsfcnfha2o00")
	SceneSwitcher.load_level_2D("uid://bg0iirp5vy6r4")



func _on_options_button_pressed():
	pass # Replace with function body.


func _on_credits_button_pressed():
	pass # Replace with function body.


func _on_quit_button_pressed():
	SaveLoad.save_data()
	get_tree().quit()
