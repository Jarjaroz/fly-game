extends CharacterBody2D

var acceleration: float = 4
@onready var name_control = $"../name_control"
@onready var king_end_timer = $"../kingEndTimer"
@onready var sprite_2d = $Sprite2D
const FL_YSPRITE = preload("res://assets/sprites/FLYsprite.png")
const FLOWER_SCALED = preload("res://assets/sprites/flower.png")
# Called when the node enters the scene tree for the first time.
func _ready():
	position.x = randi_range(200, 280)
	var choice: int = randi_range(0,10)
	if choice < 5:
		sprite_2d.texture = FL_YSPRITE
		sprite_2d.scale = Vector2(1,1)
	else:
		sprite_2d.texture = FLOWER_SCALED
		sprite_2d.scale = Vector2(0.7,0.7)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	rotation += 0.1
	acceleration = acceleration * 1.1
	position.y += acceleration*delta
	move_and_slide()


func _on_animation_finished(anim_name):
	SoundFx.play_sound(3)
	king_end_timer.start()
	name_control.show()


func _on_timer_timeout():
	SceneManager.load_menu_scene()
	SoundFx.start_music()

