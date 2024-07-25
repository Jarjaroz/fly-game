extends Area2D
@onready var leaves_falling = $LeavesFalling
@onready var gpu_particles_2d = $GPUParticles2D
@onready var sprite_2d = $Sprite2D
@onready var time_before_fall = $timeBeforeFall

const  SPEED := 1500

var falling: bool = false

func _ready():
	position.y = -510 + GameManager.camera_position.y
	falling = false
	leaves_falling.emitting = true
	time_before_fall.start()
	print("kastanje: " , position.y)

func _process(delta):
	if falling:
		position.y += SPEED*delta
	else:
		position.y = -510 + GameManager.camera_position.y
	

func _on_time_before_fall_timeout():
	falling = true


func _on_body_entered(body):
	if body.is_in_group("player"):
		SignalManager.on_hit_rose.emit()
