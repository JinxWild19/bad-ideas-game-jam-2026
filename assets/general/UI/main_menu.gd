extends CanvasLayer



func _ready():
	SaveLoad.load_data()

func _on_play_button_pressed():
	pass # Replace with function body.


func _on_options_button_pressed():
	pass # Replace with function body.


func _on_credits_button_pressed():
	pass # Replace with function body.


func _on_quit_button_pressed():
	SaveLoad.save_data()
	get_tree().quit()
