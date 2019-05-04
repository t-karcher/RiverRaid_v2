extends KinematicBody2D

var speed = 80

func explode():
	$Collider.disabled = true
	$Sprite/Animation.play("Explode")
	yield($Sprite/Animation, "animation_finished")
	self.queue_free()
	
func _process(delta):
	var c:KinematicCollision2D = move_and_collide(Vector2(speed * delta, 0))
	if is_instance_valid(c):
		if c.collider.name in ["RightBank", "LeftBank", "Island"]:
			speed *= -1
		else:
			explode()
