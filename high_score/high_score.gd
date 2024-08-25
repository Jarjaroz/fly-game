extends Area2D
@onready var animated_sprite_2d = $AnimatedSprite2D
var teller: int = 0

func _ready():
	SignalManager.on_reset_highscore.connect(on_reset_highscore)
	SignalManager.on_game_start.connect(on_game_start)
	position.y = (GameManager.highscore*-1)*100 +500
	show()

func on_game_start():
	if GameManager.highscore > 0:
		position.y = (GameManager.highscore*-1)*100 +500
		show()

func on_reset_highscore():
	position.y = (GameManager.highscore*-1)*100 +500

func _on_body_entered(body):
	if body.is_in_group("player"):
		queue_free()

func _process(delta):
	teller += 1
	position.y += 20*sin(0.1*teller)*delta
	
