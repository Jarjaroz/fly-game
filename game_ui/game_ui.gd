extends Control

@onready var timer = $Timer
@onready var height_label = $MarginContainer/heightLabel
@onready var progress_bar = $MarginContainer/ProgressBar


const STAMINA_FLAPPING_COST: int = 3
const MAX_STAMINA: int = 500
const STAMINA_DRAIN: int = 1

var stamina: int
var record_height:int = 0


func _ready():
	GameManager.max_stamina = MAX_STAMINA
	progress_bar.max_value = MAX_STAMINA
	stamina = MAX_STAMINA
	progress_bar.value = stamina
	SignalManager.on_flower_hit.connect(on_flower_hit)
	SignalManager.on_flapping_wing.connect(on_flapping_wing)
	SignalManager.on_revive.connect(on_revive)
	height_label.text = str(record_height) + " cm"
	progress_bar.value = stamina

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
	progress_bar.value = stamina

func on_flower_hit():
	stamina += GameManager.calculate_flower_boost()

func on_flapping_wing():
	if GameManager.started == false:
		return
	stamina -= STAMINA_FLAPPING_COST

func on_revive():
	timer.start()
