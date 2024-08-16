extends Area2D
@onready var animated_sprite_2d = $AnimatedSprite2D
var teller: int = 0
func _ready():
	if GameManager.highscore > 1:
		position.y = (GameManager.highscore*-1)*100 +500
		print(GameManager.highscore)
		print((GameManager.highscore*-1 )*100 +500) 
		print(position.y)
		show()

func _on_body_entered(body):
	if body.is_in_group("player"):
		queue_free()

func _process(delta):
	teller += 1
	position.y += 20*sin(0.1*teller)*delta
	
