extends Area2D
@onready var leaves_falling = $LeavesFalling
@onready var gpu_particles_2d = $GPUParticles2D
@onready var sprite_2d = $Sprite2D
@onready var time_before_fall = $timeBeforeFall
@onready var off_screen_timer = $offScreenTimer
@onready var screen_notifier = $VisibleOnScreenNotifier2D

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


func _on_visible_on_screen_notifier_2d_screen_exited():
	off_screen_timer.start()


func _on_off_screen_timer_timeout():
	if !screen_notifier.is_on_screen():
		queue_free()
