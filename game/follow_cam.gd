extends Camera2D


@onready var player = $"../Player"

var screenWidth = 480
var screenHeight = 854
var distance: float
var lerp_speed: float  # Speed at which the camera moves
var target_position_y

func _ready():
	SignalManager.on_game_over.connect(on_game_over)


func _physics_process(delta):
	if !GameManager.is_stamina_gone && !GameManager.menu_start:
		distance = player.position.y - position.y -150
		if(distance<0):
				position.y += (10* distance/2)*delta
	GameManager.set_camera_position(position)

func on_game_over():
	process_mode = Node.PROCESS_MODE_DISABLED

