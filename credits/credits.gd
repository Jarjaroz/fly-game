extends Control

func _on_close_button_pressed():
	self.hide()
	SoundFx.play_sound(1)
