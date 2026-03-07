extends Node

const SAVE_FILE = "user://savefile.json"

var content_to_save = {
	"fights" = {
		"fight_level_1" = LevelCore.fight_level_1_completed,
		"fight_level_2" = LevelCore.fight_level_2_completed,
		"fight_level_3" = LevelCore.fight_level_3_completed,
		"fight_level_4" = LevelCore.fight_level_4_completed,
		"fight_level_5" = LevelCore.fight_level_5_completed,
		"fight_level_6" = LevelCore.fight_level_6_completed,
		"fight_level_7" = LevelCore.fight_level_7_completed,
	},
	"memories" = {
		"memory_1_completed" = LevelCore.memory_1_completed,
		"memory_2_completed" = LevelCore.memory_2_completed,
		"memory_3_completed" = LevelCore.memory_3_completed,
		"memory_4_completed" = LevelCore.memory_4_completed,
		"memory_5_completed" = LevelCore.memory_5_completed,
		"memory_6_completed" = LevelCore.memory_6_completed,
		},
	"audio_settings" = {
		"Master_volume" : 1.0,
		"Music_volume" : 1.0,
		"SFX_volume" : 1.0,
	},
	"global_variabls" = {
		
	},
	"player" = {
		
	},
	"enemy" = {
		
	},
}

func _ready():
	load_data()

func load_data():
	if not FileAccess.file_exists(SAVE_FILE):
		print("No save file found, using default settings.")
		return
	var file = FileAccess.open(SAVE_FILE, FileAccess.READ)
	if file:
		var content = file.get_as_text()
		var parsed_json = JSON.parse_string(content)
		
		if parsed_json is Dictionary:
			content_to_save = parsed_json
			print("Save data loaded: ", content_to_save)
		else:
			print("Error: Save file is corrupted.")
		
		file.close()

func save_data():
	var file = FileAccess.open(SAVE_FILE, FileAccess.WRITE)
	var json = JSON.stringify(content_to_save)
	file.store_string(json)
	file.close()
