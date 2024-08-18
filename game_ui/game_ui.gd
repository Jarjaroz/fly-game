extends Control

@onready var timer = $Timer
@onready var height_label = $MarginContainer/HealthBar/VBoxContainer/heightLabel
@onready var health_bar = $MarginContainer/HealthBar

const STAMINABAR_FILL_YEL = preload("res://assets/sprites/staminabar_fill2.png")
const STAMINABAR_FILL_RED = preload("res://assets/sprites/staminabar_fill_red2.png")

const STAMINA_FLAPPING_COST: int = 3
const MAX_STAMINA: int = 500
const STAMINA_DRAIN: int = 1

var stamina: int
var record_height:int = 0
var is_flapping: bool = false



func _ready():
	GameManager.max_stamina = MAX_STAMINA
	health_bar.max_value = MAX_STAMINA
	stamina = MAX_STAMINA
	health_bar.value = stamina
	
	SignalManager.on_flower_hit.connect(on_flower_hit)
	SignalManager.on_flapping_wing.connect(on_flapping_wing)
	SignalManager.on_revive.connect(on_revive)
	
	height_label.text = str(record_height) + " cm"
	
	change_color_tint()

func _on_timer_timeout():
	if GameManager.started == false:
		return
	GameManager.stamina = stamina
	if stamina == 0:
		SignalManager.on_timer_zero.emit()
		timer.stop()
	else:
		stamina -= STAMINA_DRAIN
	var string_time = str(stamina)
	string_time = string_time.insert(string_time.length() - 1, ".")
	if len(string_time) < 3:
		string_time = string_time.insert(0, "0")
	if  record_height < round((GameManager.player_position.y*-1 + 500)/100):
		record_height = round((GameManager.player_position.y*-1 +500)/100) 
	height_label.text = str(record_height) + " cm"
	GameManager.set_score(record_height)
	stamina = clamp(stamina,0, MAX_STAMINA)
	health_bar.value = stamina	
	change_color_tint()

func on_flower_hit():
	stamina += GameManager.calculate_flower_boost()


func on_flapping_wing():
	is_flapping = true
	if GameManager.started == false:
		return
	stamina -= STAMINA_FLAPPING_COST

func on_revive():
	timer.start()


func change_color_tint():
	if (health_bar.value / health_bar.max_value) > 0.35:
		health_bar.texture_progress = STAMINABAR_FILL_YEL
	else:
		health_bar.texture_progress = STAMINABAR_FILL_RED

func _on_loss_timer_timeout():
	is_flapping = false
