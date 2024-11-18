extends CharacterBody2D


const GRAVITY: float = 2000.0
const POWER: float = 7000.0
const TURN_POWER: float = 25
const RECENTER_POWER: float = 0.5
const SLOW_DOWN_POWER: float = 3
const SLOW_DOWN_DEGREES: float = 15
const TURN_TIME: float = 15

var turn_counter: int = 0
var turn_direction: int = 0 
var current_power: float = 0
var is_death: bool = false

@onready var time_after_death = $TimeAfterDeath
@onready var sprite_animated = $SpriteAnimated
@onready var visible_notifier = $VisibleOnScreenNotifier2D


func _ready():
	SignalManager.on_timer_zero.connect(on_timer_zero)
	SignalManager.on_revive.connect(on_revive)
	SignalManager.on_hit_rose.connect(on_hit_rose)
	GameManager.is_fully_death = false
	set_process_input(true)
	


func _input(event):
	if GameManager.menu_start:
		return
	if(!GameManager.is_stamina_gone && !GameManager.is_fully_death):
		if event is InputEventScreenTouch and event.pressed:
			var touch_position = event.position.x
			if touch_position < 240:
				SignalManager.on_flapping_wing.emit()
				turn_direction = 1
				turn_counter = 0
				play_animation(turn_direction)
			elif touch_position >= 240:
				SignalManager.on_flapping_wing.emit()
				turn_direction = -1
				turn_counter = 0
				play_animation(turn_direction)
			else:
				play_animation(0)
		else:
			if Input.is_action_just_pressed("left") == true:
				SignalManager.on_flapping_wing.emit()
				turn_direction = 1
				turn_counter = 0

			elif Input.is_action_just_pressed("right") == true:
				SignalManager.on_flapping_wing.emit()
				turn_direction = -1
				turn_counter = 0
				play_animation(turn_direction)

			else:
				play_animation(0)
	else:
		play_animation(3)

func _physics_process(delta):
	if(!GameManager.is_stamina_gone && !GameManager.is_fully_death):
		turn(delta)
		recenter()
	slow_down()
	apply_gravity(delta)
	GameManager.set_var_player_position(position)
	move_and_slide()
	if GameManager.started == false:
		if turn_direction != 0:
			GameManager.started = true
			SignalManager.on_first_flap.emit()

func turn(delta: float) -> void:
	turn_counter += 1
	if(TURN_TIME <= turn_counter || turn_direction == 0):
		turn_direction = 0
		return
	rotation_degrees += TURN_POWER/TURN_TIME * turn_direction
	current_power = -4 * turn_counter * turn_counter * turn_counter + POWER
	if velocity.y > -500:
		velocity += Vector2(current_power * delta * cos(deg_to_rad(rotation_degrees-90))
				,current_power * delta * sin(deg_to_rad(rotation_degrees-90)))
	else:
		velocity += Vector2(0.5 * current_power * delta * cos(deg_to_rad(rotation_degrees-90))
				,0.5 *current_power * delta * sin(deg_to_rad(rotation_degrees-90)))

func slow_down() -> void:
	if velocity.x == 0:
		return
	if is_on_floor() and abs(rotation_degrees) < SLOW_DOWN_DEGREES:
		velocity.x =0

func recenter() -> void:
	if(abs(rotation_degrees) < 2):
		return
	if(rotation_degrees > 0):
		if is_on_floor():
			rotation_degrees -= RECENTER_POWER*5
		else:
			if turn_counter < 0.60*TURN_TIME:
				rotation_degrees -= 0.6*RECENTER_POWER
			else:
				rotation_degrees -= RECENTER_POWER
	else:
		if is_on_floor():
			rotation_degrees += RECENTER_POWER*5
		else:
			if turn_counter < 0.60*TURN_TIME:
				rotation_degrees += 0.6*RECENTER_POWER
			else:
				rotation_degrees += RECENTER_POWER

func play_animation(turn_direction: int) -> void:
	if GameManager.started == false:
		sprite_animated.play("blink")
	if turn_direction == -1:
		sprite_animated.play("flap_R")
	elif turn_direction == 1:
		sprite_animated.play("flap_L")
	elif turn_direction == 0:
		sprite_animated.play("default")
	elif turn_direction == 3:
		sprite_animated.play("death")
	elif turn_direction == 4:
		sprite_animated.play("blink")

func apply_gravity(delta: float) -> void:
	if velocity.y < 500:
		velocity.y += GRAVITY*delta
	else:
		velocity.y += 0.60 * GRAVITY*delta

func on_timer_zero() -> void:
	is_death = true
	GameManager.is_stamina_gone = true
	print("stamina gone")
	time_after_death.start()



func on_hit_rose() -> void:
	print("on_hit_rose")
	GameManager.is_other_death = true
	GameManager.is_stamina_gone = true
	time_after_death.start()
	play_animation(3)

func on_revive() -> void:
	print("revive")
	play_animation(4)
	GameManager.is_stamina_gone = false

func _on_visible_on_screen_notifier_2d_screen_exited():
	GameManager.is_death_by_screen = true
	time_after_death.start()

func _on_time_after_death_timeout() -> void:
	time_after_death.stop()
	print("misa on screen?")
	print(visible_notifier.is_on_screen())
	if visible_notifier.is_on_screen() && GameManager.is_death_by_screen:
		GameManager.is_death_by_screen = false
		play_animation(4)
		return
	if GameManager.is_stamina_gone or GameManager.is_other_death or GameManager.is_death_by_screen:
		if !GameManager.is_fully_death:
			print("dead")
			SignalManager.on_game_over.emit()
			GameManager.is_fully_death = true
