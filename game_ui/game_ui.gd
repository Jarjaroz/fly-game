extends Control

@onready var timer = $Timer
@onready var height_label = $MarginContainer/heightLabel
@onready var health_bar = $MarginContainer/HealthBar
@onready var loss_bar = $MarginContainer/HealthBar/LossBar
@onready var loss_timer = $MarginContainer/HealthBar/LossTimer

var sb = StyleBoxFlat.new()
const SB_YELLOW_TRANS = preload("res://game_ui/sb_yellow_trans.tres")
const SB_ORANGE_TRANS = preload("res://game_ui/sb_orange_trans.tres")

const STAMINA_FLAPPING_COST: int = 3
const MAX_STAMINA: int = 500
const STAMINA_DRAIN: int = 1

var stamina: int
var record_height:int = 0
var is_flapping: bool = false



func _ready():
	GameManager.max_stamina = MAX_STAMINA
	health_bar.max_value = MAX_STAMINA
	loss_bar.max_value = MAX_STAMINA
	stamina = MAX_STAMINA
	health_bar.value = stamina
	loss_bar.value = stamina
	
	SignalManager.on_flower_hit.connect(on_flower_hit)
	SignalManager.on_flapping_wing.connect(on_flapping_wing)
	SignalManager.on_revive.connect(on_revive)
	
	height_label.text = str(record_height) + " cm"
	
	health_bar.add_theme_stylebox_override("fill", sb)
	sb.corner_radius_bottom_left = 7
	sb.corner_radius_bottom_right = 7
	sb.corner_radius_top_left = 7
	sb.corner_radius_top_right = 7
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
	if(!is_flapping):
		if loss_bar.value > health_bar.value:
			loss_bar.value -= STAMINA_DRAIN*6
		else:
			loss_bar.value = health_bar.value-1
	else:
		loss_bar.value -= STAMINA_DRAIN
	change_color_tint()

func on_flower_hit():
	stamina += GameManager.calculate_flower_boost()
	loss_bar.value = stamina

func on_flapping_wing():
	loss_timer.start()
	is_flapping = true
	if GameManager.started == false:
		return
	stamina -= STAMINA_FLAPPING_COST

func on_revive():
	timer.start()


func change_color_tint():
	if (health_bar.value / health_bar.max_value) > 0.35:
		sb.bg_color = SB_YELLOW_TRANS.bg_color
	else:
		sb.bg_color = SB_ORANGE_TRANS.bg_color

func _on_loss_timer_timeout():
	is_flapping = false
