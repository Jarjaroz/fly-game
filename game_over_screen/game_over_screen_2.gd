extends Control

@onready var highscore_label = $MarginContainer/VBoxContainer/HighscoreLabel
@onready var score_label = $MarginContainer/VBoxContainer/ScoreLabel
@onready var replay_button = $MarginContainer/VBoxContainer/ReplayButton

# Called when the node enters the scene tree for the first time.
func _ready():
	SignalManager.on_game_over.connect(on_game_over)

func on_game_over():
	score_label.text = str(GameManager.current_score) + " cm"
	highscore_label.text = "highscore: %s cm" % GameManager.highscore
	SaveScore.save_score()
	replay_button.grab_focus()

func _on_replay_button_pressed():
	SceneManager.load_game_scene()

func _on_menu_button_pressed():
	SceneManager.load_menu_scene()
