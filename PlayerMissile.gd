extends KinematicBody2D

func _ready():
	destroy() # Reset / hide missile at startup

func _process(delta):
	var c:KinematicCollision2D = move_and_collide (Vector2(0,-500*delta))
	if is_instance_valid(c):
		if c.collider.has_method("explode"):
			c.collider.explode()
		destroy()

func destroy():
	hide()
	set_process(false)

# Start a new missile
# (unless the old one is still visible) 
func shootMissileFrom(playerPos):
	if !visible:
		set_position(Vector2(playerPos.x, playerPos.y + 8))
		show()
		set_process(true)

# Reset missile once it exits the visible screen
func _on_VisibilityNotifier2D_screen_exited():
	destroy()