extends Area2D

var vehicle : Node2D
var vehiclePos
enum { ON_STREET, ON_BRIDGE }


func explode():
	if is_instance_valid(vehicle):
		if vehiclePos == ON_BRIDGE:
			vehicle.explode()
		else:
			vehicle.stop()
	$Sprite/Animation.play("Explode")
	yield($Sprite/Animation, "animation_finished")
	$Sprite.hide()

func _on_Bridge_body_shape_entered(body_id, body, body_shape, area_shape):
	if body.name in ["Player", "PlayerMissile"]:
		explode()
	elif body.name == "Vehicle":
		vehicle = body
		if area_shape == 0:
			vehiclePos = ON_BRIDGE
		else:
			vehiclePos = ON_STREET
