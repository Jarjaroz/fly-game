extends Control

@onready var highscore_label = $MarginContainer/VBoxContainer/HighscoreLabel
@onready var score_label = $MarginContainer/VBoxContainer/ScoreLabel
@onready var replay_btn = $MarginContainer/VBoxContainer/ReplayBtn


func _ready():
	SignalManager.on_game_over.connect(on_game_over)

func on_game_over():
	score_label.text = str(GameManager.current_score) + " cm"
	highscore_label.text = "highscore: %s cm" % GameManager.highscore
	replay_btn.grab_focus()


func _on_replay_btn_pressed():
	SceneManager.load_game_scene()


func _on_menu_btn_pressed():
	SceneManager.load_menu_scene()