extends Node2D

@onready var highscore = $main_menu_ui/MarginContainer/VBoxContainer/Highscore

# Called when the node enters the scene tree for the first time.
func _ready():
	highscore.text = "RECORD: %s" % str(GameManager.highscore)

func _on_play_button_pressed():
	SceneManager.load_game_scene()
