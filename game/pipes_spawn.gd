extends Node2D

func _process(delta):
	position.y = GameManager.get_var_player_position().y
