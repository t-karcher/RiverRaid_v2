extends Node2D

var emptyPos: float = -29
var displayWidth: float = 54

func _ready():
	$Marker.set_position(Vector2(25, -3)) # init marker position

func _on_Player_fuel_updated(fuel):
	$Marker.set_position(Vector2 (int(emptyPos + ((displayWidth / 100) * fuel)), -3))
