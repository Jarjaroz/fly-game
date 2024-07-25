extends CharacterBody2D

var spawned_new_pipe:bool = false
@onready var flower = $flower

func _ready():
	spawned_new_pipe = false
	if GameManager.flowerNeeded:
		GameManager.flowerNeeded = false
		flower.show()

func _process(_delta):
	#velocity = Vector2(0,GameManager.get_var_player_velocity().y*-1) 
	var player_pos:Vector2 = GameManager.get_var_player_position()
	if player_pos.y < (position.y -GameManager.calculate_space_between_pipes()) && !spawned_new_pipe:
		SignalManager.on_spawn_new_pipe.emit()
		spawned_new_pipe = true
	move_and_slide()

func _on_screen_exited():
	var player_pos:Vector2 = GameManager.get_var_player_position()
	if(player_pos.y < position.y):
		queue_free()
