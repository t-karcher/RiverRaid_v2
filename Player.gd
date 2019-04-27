extends KinematicBody2D

# Declare member variables here. Examples:
const MOVE_SPEED = 3
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	move_and_collide(Vector2(0,-2))
	$Sprite.frame = 0
	if Input.is_action_pressed("ui_left"):
		$Sprite.frame = 2
		move_and_collide(Vector2(-MOVE_SPEED,0))
	if Input.is_action_pressed("ui_right"):
		$Sprite.frame = 1
		move_and_collide(Vector2(MOVE_SPEED,0))