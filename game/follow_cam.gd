extends Camera2D


@onready var player = $"../Player"

var screenWidth = 480
var screenHeight = 854
var distance: float
var lerp_speed: float  # Speed at which the camera moves

func _ready():
	SignalManager.on_game_over.connect(on_game_over)

func _physics_process(delta):
	if !GameManager.is_stamina_gone:
		distance = (player.position.y - 150) - position.y
		
		# Calculate the target position
		var target_position_y = position.y + (player.position.y- 500 - position.y) * delta
		lerp_speed = distance * -2
		if(distance<0):
			position.y = lerp(position.y, target_position_y, lerp_speed * delta)
		
		# Update the GameManager with the new camera position
		GameManager.set_camera_position(position)	

func on_game_over():
	process_mode = Node.PROCESS_MODE_DISABLED

