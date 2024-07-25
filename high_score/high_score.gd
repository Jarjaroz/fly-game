extends Area2D

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
