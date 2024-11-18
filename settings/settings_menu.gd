extends Control

@onready var music_slider = $MarginContainer/NinePatchRect/MarginContainer/VBoxContainer/MusicSlider
@onready var sound_slider = $MarginContainer/NinePatchRect/MarginContainer/VBoxContainer/SoundSlider
@onready var reset_button = $MarginContainer/NinePatchRect/MarginContainer/VBoxContainer/ResetButton
@onready var you_sure = $MarginContainer/YouSure

var sliders_activated: bool = false

func _on_close_button_pressed():
	SoundFx.play_sound(1)
	self.hide()

func _ready():
	music_slider.value = SoundFx.get_music_volume()
	sound_slider.value = SoundFx.get_sound_volume()
	

func _process(delta):
	if !sliders_activated:
		return
	SoundFx.set_music_volume(music_slider.value)
	SoundFx.set_sound_volume(sound_slider.value)

func _on_slider_drag_started():
	sliders_activated = true


func _on_slider_drag_ended(_value_changed):
	sliders_activated = false
	SaveScore.save_data()


func _on_sound_slider_drag_ended(_value_changed):
	sliders_activated = false
	SoundFx.play_sound(0)
	SaveScore.save_data()

func _on_reset_button_pressed():
	you_sure.show()
	SoundFx.play_sound(0)


func _on_yes_button_pressed():
	you_sure.hide()
	self.hide()
	SoundFx.play_sound(2)
	SaveScore.reset_score()
	GameManager.highscore = 0
	SignalManager.on_reset_highscore.emit()


func _on_no_button_pressed():
	you_sure.hide()
	self.hide()
	SoundFx.play_sound(1)
