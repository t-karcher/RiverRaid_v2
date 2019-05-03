extends Area2D

func _on_Fuel_body_entered(body):

	# If player enters: Start filling up player
	if body.name == "Player":
		body.isFillingUp = true

	# If anything else enters: Explode
	else:
		$Sprite/Animation.play("Explode")
		yield($Sprite/Animation, "animation_finished")
		self.queue_free()

func _on_Fuel_body_exited(body):
	# Stop filling up the player once the plane exits
	if body.name == "Player":
		body.isFillingUp = false