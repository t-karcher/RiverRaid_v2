extends KinematicBody2D

var move_speed = -150
var missile: KinematicBody2D

func _ready():
	$Sprite/Animation.play("fly")

func explode():
	$Collider.disabled = true
	missile.queue_free()
	$Sprite/Animation.play("Explode")
	yield($Sprite/Animation, "animation_finished")
	self.queue_free()

func _process(delta):
	var c:KinematicCollision2D = move_and_collide(Vector2(move_speed * delta, 0))
	if is_instance_valid(c):
		if c.collider.name in ["RightBank", "LeftBank", "Island"]:
			move_speed *= -1
			$Sprite.flip_h = !$Sprite.flip_h
		else:
			explode()
