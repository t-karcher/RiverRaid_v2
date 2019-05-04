extends KinematicBody2D

var missile_speed = 500
var get_shooter_pos: FuncRef
var get_shooter_flip_h: FuncRef

func _process(delta):
	var c:KinematicCollision2D = move_and_collide (Vector2(missile_speed * delta, 0))
	if is_instance_valid(c):
		if c.collider.has_method("explode"):
			c.collider.explode()
		shootMissile()

# Start a new missile
func shootMissile():
	set_position(get_shooter_pos.call_func())
	var dir = 1 if get_shooter_flip_h.call_func() else -1
	set_scale(Vector2(dir, -1))
	missile_speed = 500 * dir 