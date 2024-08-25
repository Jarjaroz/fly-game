extends CharacterBody2D

var acceleration: float = 4
@onready var name_control = $"../name_control"
@onready var king_end_timer = $"../kingEndTimer"
@onready var sprite_2d = $Sprite2D
const THE_ROYAL_GUY = preload("res://assets/sprites/theRoyalGuy.png")
const FL_YSPRITE = preload("res://assets/sprites/FLYsprite.png")
const FLOWER_SCALED = preload("res://assets/sprites/flower_scaled.png")
# Called when the node enters the scene tree for the first time.
func _ready():
	position.x = randi_range(200, 280)
	var choice: int = randi_range(0,3)
	if choice == 0:
		sprite_2d.texture = FL_YSPRITE
	elif choice == 1:
		sprite_2d.texture = FLOWER_SCALED
	else: 
		sprite_2d.texture = THE_ROYAL_GUY


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	rotation += 0.1
	acceleration = acceleration * 1.1
	position.y += acceleration*delta
	print(position.y)
	move_and_slide()


func _on_animation_finished(anim_name):
	SoundFx.play_sound(3)
	king_end_timer.start()
	name_control.show()


func _on_timer_timeout():
	SceneManager.load_menu_scene()
	SoundFx.start_music()

