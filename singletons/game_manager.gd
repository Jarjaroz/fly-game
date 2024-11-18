extends Node

const space_between_pipes: int = 300
var player_position: Vector2
var camera_position: Vector2

var is_fully_death: bool = false
var is_stamina_gone: bool = false
var is_other_death: bool = false
var is_death_by_screen: bool = false
var started: bool = false
var menu_start: bool = true 

var current_score: int = 0
var highscore: int = 0

var pipes_passed: int = 0
var pipe_before_flower : int = 0
var pipe_rest: int = 0

var flowers_hit: int = 0
var max_stamina: int
var stamina: int
var flowerNeeded: bool = false

func _ready():
	SignalManager.on_flower_hit.connect(flower_hit)
	pipe_before_flower  = 2
	pipe_rest = 0
	
func set_var_player_position(veckie: Vector2) -> void:
	player_position = veckie

func set_camera_position(veckie: Vector2) -> void:
	camera_position = veckie

func set_score(score: int):
	current_score = score
	if score > highscore:
		highscore = score

func get_var_player_position() -> Vector2:
	return player_position

func flower_hit():
	flowers_hit += 1

func calculate_flower_boost() -> int:
	#var return_value: int
	#var stamina_calc: int = round((max_stamina - stamina)/3)
	
	#return_value = stamina_calc + 100 - flowers_hit*4 
	#print(return_value)
	#if return_value < 100:
	#	return_value = 100
	return max_stamina/2

func calculate_kastanje_time() -> int:
	var return_value: int
	if pipes_passed < 45:
		return_value = roundi(-1/3 * (pipes_passed) + 25)
	else:
		return_value = 9
	return_value += randi_range(0,7)
	return return_value

func calculate_space_between_pipes() -> int:
	var return_value: int
	return_value = space_between_pipes - pipes_passed*3
	if return_value < -60:
		return_value = -60
	return return_value 

func increase_pipes_passed() -> void:
	pipes_passed+= 1
	if (pipes_passed-pipe_rest)%pipe_before_flower == 0:
		print("flower %s" % flowers_hit)
		flowerNeeded = true
		pipe_rest = pipes_passed
		if flowers_hit < 3:
			pipe_before_flower +=1
		elif flowers_hit < 6:
			pipe_before_flower = 6
		elif flowers_hit < 9:
			pipe_before_flower = 7
		elif flowers_hit < 15:
			pipe_before_flower = 8
		elif flowers_hit < 20:
			pipe_before_flower = 9
		elif flowers_hit < 23:
			pipe_before_flower = 10
		elif flowers_hit < 25:
			pipe_before_flower = 11
		elif flowers_hit < 27:
			pipe_before_flower = 13
		else:
			pipe_before_flower = 15
	else:
		print("twig")
	

func reset_flight_vars():
	player_position = Vector2(0,0)
	flowers_hit = 0
	is_fully_death= false
	is_stamina_gone = false
	is_other_death = false
	started = false
	current_score = 0
	pipes_passed = 0
	flowerNeeded = false
	pipe_before_flower  = 2

	
