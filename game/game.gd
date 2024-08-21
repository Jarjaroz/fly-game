extends Node2D

@onready var game_ui = $GameCanvas/gameUI
@onready var player = $Player
@onready var pipes_holder = $pipesHolder
@onready var spawn_left = $world_boundries2/SpawnLeft
@onready var spawn_right = $world_boundries2/SpawnRight
@onready var game_over_ui = $GameCanvas/game_over_screen
@onready var kastanje_holder = $kastanjeHolder
@onready var kastanje_timer = $KastanjeTimer


enum type_of_pipe {STATIC, VFLIP, VFLIP_RAND_X}

@export var pipes: Array[PackedScene]
@export var kastanje: PackedScene
@export var leaves: PackedScene
var types_of_pipes_array: Array = [type_of_pipe.VFLIP_RAND_X,
									type_of_pipe.VFLIP,
									type_of_pipe.VFLIP,
									type_of_pipe.VFLIP,
									type_of_pipe.VFLIP_RAND_X
								   ]




func _ready():
	SignalManager.on_first_flap.connect(on_first_flap)
	SignalManager.on_spawn_new_pipe.connect(spawn_pipes)
	SignalManager.on_game_over.connect(on_game_over)
	SignalManager.on_spawn_new_pipe.emit()
	game_over_ui.hide()
	if GameManager.menu_start:
		game_ui.hide()
	else:
		game_ui.show()

func on_first_flap() -> void:
	kastanje_timer.wait_time = randi_range(7,12)
	kastanje_timer.start()

func spawn_pipes() -> void:
	
	var x_pos = 240
	var new_pipes
	var flip: int = 1
	var rand_num: int
	if randi_range(1,2) == 1:
		rand_num = randi_range(0,4)
	else:
		rand_num = randi_range(0,2)
	#rand_num = 4
	new_pipes = pipes[rand_num].instantiate()
	var type_new_pipes = types_of_pipes_array[rand_num]
	
	if type_new_pipes == type_of_pipe.VFLIP_RAND_X:
		x_pos = randf_range(spawn_left.position.x, spawn_right.position.x)
		if 1 == randi_range(1,2):
			flip = 1
		else:
			flip = -1
	elif type_new_pipes == type_of_pipe.VFLIP:
		if 1 == randi_range(1,2):
			flip = 1
		else:
			flip = -1
	new_pipes.position = Vector2(x_pos, spawn_left.position.y)
	new_pipes.scale.x = new_pipes.scale.x * flip
	pipes_holder.add_child(new_pipes)
	GameManager.increase_pipes_passed()
func stop_pipes() -> void:
	for pipes in pipes_holder.get_children():
		pipes.set_process(false)

func spawn_kastanje() -> void:
	var x_pos: int
	var new_kastanje
	new_kastanje = kastanje.instantiate()
	x_pos = randf_range(spawn_left.position.x, spawn_right.position.x)
	new_kastanje.position = Vector2(x_pos, spawn_left.position.y)
	kastanje_holder.add_child(new_kastanje)
	kastanje_timer.wait_time = GameManager.calculate_kastanje_time()
	kastanje_timer.start()

func on_game_over():
	stop_pipes()
	game_over_ui.show()
	game_ui.hide()



func _on_kastanje_timer_timeout():
	spawn_kastanje()
	#print("spawn_kastanje()")
