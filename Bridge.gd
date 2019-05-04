extends Area2D

func explode():
	$Sprite/Animation.play("Explode")
	yield($Sprite/Animation, "animation_finished")
	$Sprite.hide()

func _on_Bridge_body_entered(body):
	# If player enters: Start filling up player
	if body.name in ["Player", "PlayerMissile"]:
		explode()