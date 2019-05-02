extends KinematicBody2D

# Called when the node enters the scene tree for the first time.
func _ready():
	destroy()

func _process(delta):
	var c = move_and_collide (Vector2(0,-500*delta))
	if is_instance_valid(c):
		# check collision object
		destroy()

func destroy():
	hide()
	set_process(false)

func _on_Player_missile_shot(shooterPos):
	if !visible:
		set_position(Vector2(shooterPos.x, shooterPos.y + 12))
		show()
		set_process(true)

func _on_VisibilityNotifier2D_screen_exited():
	destroy()