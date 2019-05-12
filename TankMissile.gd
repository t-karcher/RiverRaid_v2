extends KinematicBody2D

var missile_speed = 500
var tank: KinematicBody2D
const shooting_distance = {SHORT = 30,	LONG = 90} 
var is_exploding = false

func _ready():
	$Collider.disabled = true # only active during explosion
	set_process(false) # wait for shooting signal

func _process(delta):
	if abs(position.x - tank.position.x) < shooting_distance.SHORT:
		var c := move_and_collide (Vector2(missile_speed * delta, 0)) as KinematicCollision2D
	else:
		if !is_exploding:
			is_exploding = true
			explode()

func explode():
	$Collider.disabled = false
	$Sprite/Animation.play("Explode")
	yield($Sprite/Animation, "animation_finished")
	startMissile()

func startShooting():
	set_process(true)
	startMissile()

# Start a new missile
func startMissile():
	is_exploding = false
	$Collider.disabled = true # only active during explosion
	set_position(Vector2(tank.position.x, tank.position.y - 3))
	$Sprite.frame = 4
	var dir = -1 if tank.get_node("Sprite").is_flipped_h() else 1
	set_scale(Vector2(dir, -1))
	missile_speed = 500 * dir 