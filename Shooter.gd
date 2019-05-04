extends Node2D

func _ready():
	$ArmedHeli.missile = $Missile
	$Missile.get_shooter_pos = funcref($ArmedHeli, "get_position")
	$Missile.get_shooter_flip_h = funcref($ArmedHeli/Sprite, "is_flipped_h")
	$Missile.shootMissile()
