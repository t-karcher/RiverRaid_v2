extends KinematicBody2D

var speed = 100

enum {
	MODE_DRIVING,
	MODE_SHOOTING,
	MODE_WAITING
}

var mode = MODE_DRIVING
var missile: KinematicBody2D

func stop():
	mode = MODE_SHOOTING

func explode():
	$Collider.disabled = true
	$Sprite/Animation.play("Explode")
	yield($Sprite/Animation, "animation_finished")
	self.queue_free()

func _ready():
	$Sprite/Animation.play("Drive")
	
func _process(delta):
	if mode == MODE_DRIVING:
		var c:KinematicCollision2D = move_and_collide(Vector2(speed * delta, 0))
		if is_instance_valid(c):
			if c.collider.name in ["RightBank", "LeftBank", "Island"]:
				$Sprite/Animation.stop(true)
				mode = MODE_SHOOTING # if randf() < 1 else MODE_WAITING			
			else:
				explode()
	else:
		if mode == MODE_SHOOTING: missile.startShooting()
		print ("Boom!")
		set_process(false)
