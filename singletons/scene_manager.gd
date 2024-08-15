extends Node

@export var game_scene: PackedScene = preload("res://game/game.tscn")
@export var menu_scene: PackedScene = preload("res://main_menu/main_menu.tscn")

func load_game_scene():
	GameManager.reset_flight_vars()
	get_tree().change_scene_to_packed(game_scene)

func load_menu_scene():
	get_tree().change_scene_to_packed(menu_scene)
