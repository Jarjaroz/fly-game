extends Control

@export var game_scene: PackedScene

@onready var highscore = $MarginContainer/VBoxContainer/Highscore

func _ready():
	call_deferred("set_record")
	

func set_record():
	highscore.text = "RECORD: %s" % str(GameManager.highscore)

func _on_play_button_pressed():
	SceneManager.load_game_scene()
