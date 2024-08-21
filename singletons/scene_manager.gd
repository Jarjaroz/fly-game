extends Node

@export var game_scene: PackedScene = preload("res://game/game.tscn")


func load_game_scene():
	GameManager.reset_flight_vars()
	GameManager.menu_start = false
	get_tree().change_scene_to_packed(game_scene)

func load_menu_scene():
	GameManager.reset_flight_vars()
	GameManager.menu_start = true
	get_tree().change_scene_to_packed(game_scene)
