extends CharacterBody2D

@onready var collision_shape_2d = $CollisionShape2D
@onready var collision_shape_2d_2 = $CollisionShape2D2
@onready var spawn_right = $SpawnRight
@onready var spawn_left = $SpawnLeft

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	position.y = GameManager.get_var_player_position().y -50
	spawn_left.position.y = position.y -460
	spawn_right.position.y = position.y -460
	
	
