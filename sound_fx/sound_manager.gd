extends Node
@onready var button_click = $ButtonClick
@onready var music = $Music
@onready var button_click_2 = $ButtonClick2
@onready var argg = $Argg
@onready var game_over = $GameOver

func start_music():
	music.play()

func play_sound(sound_num: int):
	if sound_num == 0:
		button_click.play()
	if sound_num == 1:
		button_click_2.play()
	if sound_num == 2:
		argg.play()
	if sound_num == 3:
		game_over.play()

func set_music_volume(volume: float):
	AudioServer.set_bus_volume_db(1, linear_to_db(volume/100))

func set_sound_volume(volume: float):
	AudioServer.set_bus_volume_db(2, linear_to_db(volume/100))

func get_music_volume():
	return db_to_linear(AudioServer.get_bus_volume_db(1))*100

func get_sound_volume():
	return db_to_linear(AudioServer.get_bus_volume_db(2))*100
