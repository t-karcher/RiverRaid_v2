extends Node2D

func _ready():
	$Vehicle.missile = $Missile
	$Missile.tank = $Vehicle
