extends KinematicBody2D

func explode():
	$Sprite/Animation.play("Explode")
	yield($Sprite/Animation, "animation_finished")
	self.queue_free()
