extends KinematicBody2D

var fuel = 100 setget changeFuel
var isFillingUp = false
const MOVE_SPEED = 200
var shootMissileFrom: FuncRef

signal fuel_updated

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	move_and_collide(Vector2(0,(-MOVE_SPEED / 3) * delta))
	$Body.frame = 0
	if Input.is_action_pressed("ui_left"):
		$Body.frame = 2
		move_and_collide(Vector2(-MOVE_SPEED * delta,0))
	if Input.is_action_pressed("ui_right"):
		$Body.frame = 1
		move_and_collide(Vector2(MOVE_SPEED * delta,0))
	if Input.is_action_pressed("ui_shoot"):
		shootMissileFrom.call_func(self.position)
	if isFillingUp: changeFuel (10 * delta)

func changeFuel (diff):
	if fuel <= 0:
		#tot
		pass
	else:
		fuel = fuel + diff if fuel + diff < 100 else 100
		emit_signal("fuel_updated", fuel)

func _on_FuelTicker_timeout():
	if !isFillingUp: changeFuel (-2)