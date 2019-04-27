tool
extends Node2D

export (int) var startWidth = 30 setget setStartWidth
export (int) var endWidth = 40 setget setEndWidth
export (int) var startJitter = 5 setget setStartJitter
export (int) var endJitter = 5 setget setEndJitter

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("RiverSection")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func setStartJitter (newVal):
	startJitter = newVal
	updateBanks()	

func setEndJitter (newVal):
	endJitter = newVal
	updateBanks()	

func setStartWidth (newVal):
	startWidth = newVal
	updateBanks()	

func setEndWidth (newVal):
	endWidth = newVal
	updateBanks()

func updateBanks ():
	if (has_node("LeftBank")):
		var newPolygon = $LeftBank.polygon
		newPolygon.set(1,Vector2(startWidth + startJitter, 0))
		newPolygon.set(2,Vector2(endWidth + endJitter, 4))
		$LeftBank.set("polygon", newPolygon)
		newPolygon.set(1,Vector2(startWidth - startJitter, 0))
		newPolygon.set(2,Vector2(endWidth - endJitter, 4))
		$RightBank.set("polygon", newPolygon)
	

func _on_Position2D_transform_changed():
	if (has_node("Position2D")):
		setStartWidth (get_node("Position2D").position.x)
		setEndWidth (get_node("Position2D").position.x)
