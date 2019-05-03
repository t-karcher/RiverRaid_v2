extends KinematicBody2D

var speed = 250

func _ready():
	set_position(Vector2(-8, position.y))

func explode():
	$Sprite/Animation.play("Explode")
	yield($Sprite/Animation, "animation_finished")
	self.queue_free()
	
func _process(delta):
	var c:KinematicCollision2D = move_and_collide(Vector2(speed * delta, 0))
	if is_instance_valid(c):
		if c.collider.name == "Player":
			explode()
	if position.x > 264: set_position(Vector2(-8, position.y))