extends Control

@onready var highscore_label = $MarginContainer/VBoxContainer/HighscoreLabel
@onready var score_label = $MarginContainer/VBoxContainer/ScoreLabel
@onready var replay_button = $MarginContainer/VBoxContainer/ReplayButton
const PINK_SCORE_FONT = preload("res://fonts/pink_score_font.tres")
const RED_SCORE_FONT = preload("res://fonts/red_score_font.tres")
@onready var game_over_lbl = $GameOverLbl



var gameoverlbl_normal: bool = true
@onready var spacer_3 = $MarginContainer/VBoxContainer/Spacer3

func _ready():
	SignalManager.on_game_over.connect(on_game_over)

func on_game_over():
	score_label.text = str(GameManager.current_score) + " cm"
	highscore_label.text = "highscore: %s cm" % GameManager.highscore
	SaveScore.save_data()
	replay_button.grab_focus()


func _on_replay_btn_pressed():
	SoundFx.play_sound(0)
	SceneManager.load_game_scene()


func _on_menu_btn_pressed():
	SoundFx.play_sound(1)
	SceneManager.load_menu_scene()


func _on_game_over_flash_timeout():
	gameoverlbl_normal = !gameoverlbl_normal
	if gameoverlbl_normal:
	
		game_over_lbl.label_settings = RED_SCORE_FONT
	else:

		game_over_lbl.label_settings = PINK_SCORE_FONT
	
