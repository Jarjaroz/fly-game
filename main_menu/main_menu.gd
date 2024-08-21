extends Control

@onready var highscore = $MarginContainer/VBoxContainer/Highscore

func _ready():
	highscore.text = "RECORD: %s" % str(GameManager.highscore)

func _on_play_button_pressed():
	SignalManager.on_game_start.emit()
	GameManager.menu_start = false
