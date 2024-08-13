extends Node

const SAVEFILE = "user://savefile.save"

func _ready():
	load_score()

func save_score():
	var file = FileAccess.open(SAVEFILE, FileAccess.WRITE_READ)
	file.store_64(GameManager.highscore)

func reset_score():
	var file = FileAccess.open(SAVEFILE, FileAccess.WRITE_READ)
	file.store_64(0)

func load_score():
	var file = FileAccess.open(SAVEFILE, FileAccess.READ)
	if FileAccess.file_exists(SAVEFILE):
		GameManager.highscore = file.get_64()

