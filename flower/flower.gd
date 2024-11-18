extends Area2D

func _on_body_entered(body):
	if body.name == "Player" and !GameManager.is_fully_death and is_visible_in_tree():
		if GameManager.is_stamina_gone:
			SignalManager.on_revive.emit()
		SignalManager.on_flower_hit.emit()
		queue_free()

