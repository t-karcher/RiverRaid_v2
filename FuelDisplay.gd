extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var displayStart: float = -29
var displayWidth: float = 54

# Called when the node enters the scene tree for the first time.
func _ready():
	$Marker.set_position(Vector2(25, -3))

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_Player_fuel_updated(fuel):
	$Marker.set_position(Vector2 (int(displayStart + ((displayWidth / 100) * fuel)), -3))
