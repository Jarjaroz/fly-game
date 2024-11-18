extends Node

const SAVEFILE = "user://savefile.save"

func _ready():
	load_data()

func make_save_dict():
	var save_dict: Dictionary = {
		"highscore": GameManager.highscore,
		"music": db_to_linear(AudioServer.get_bus_volume_db(1))*100,
		"sound": db_to_linear(AudioServer.get_bus_volume_db(2))*100
	}
	return save_dict

func save_data():
	var save_file = FileAccess.open(SAVEFILE, FileAccess.WRITE)
	var json_string = JSON.stringify(make_save_dict())
	save_file.store_line(json_string)

func reset_score():
	GameManager.highscore = 0
	save_data()

func load_data():
	if !FileAccess.file_exists(SAVEFILE):
		return
	var file = FileAccess.open(SAVEFILE, FileAccess.READ)
	while file.get_position() < file.get_length():
		var json_string = file.get_line()
		var json = JSON.new()
		var parse_result = json.parse(json_string)
		var node_data = json.get_data()
		print(node_data)
		GameManager.highscore = node_data.highscore
		SoundFx.set_music_volume(node_data.music)
		SoundFx.set_sound_volume(node_data.sound)

