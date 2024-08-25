extends Control

@onready var highscore = $MarginContainer/VBoxContainer/Highscore
@onready var settings = $Settings
@onready var credits = $Credits


func _ready():
	highscore.text = "RECORD: %s" % str(GameManager.highscore)
	SignalManager.on_reset_highscore.connect(on_reset_highscore)

func _on_play_button_pressed():
	SoundFx.play_sound(0)
	SignalManager.on_game_start.emit()
	GameManager.menu_start = false

func on_reset_highscore():
	highscore.text = "RECORD: %s" % str(GameManager.highscore)

func _on_settings_button_pressed():
	SoundFx.play_sound(1)
	settings.visible = !settings.visible
	credits.hide()


func _on_credits_button_pressed():
	SoundFx.play_sound(1)
	credits.visible = !credits.visible
	settings.hide()
