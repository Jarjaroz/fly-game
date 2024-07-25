extends Node

const space_between_pipes: int = 300
var player_position: Vector2
var camera_position: Vector2

var is_fully_death: bool = false
var is_stamina_gone: bool = false
var is_other_death: bool = false
var started: bool = false

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
	return_value = space_between_pipes - pipes_passed*5
	if return_value < -60:
		return_value = -60
	return return_value 

func increase_pipes_passed() -> void:
	pipes_passed+= 1
	if (pipes_passed-pipe_rest)%pipe_before_flower == 0:
		print("flower")
		flowerNeeded = true
		pipe_rest = pipes_passed
		if pipe_before_flower<4:
			pipe_before_flower +=1
		elif pipe_before_flower<7:
			if (pipes_passed-pipe_rest)%(pipe_before_flower*2) == 0:
				pipe_before_flower +=1
		else:
			if (pipes_passed-pipe_rest)%(pipe_before_flower*3) == 0:
				pipe_before_flower +=1
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

	
