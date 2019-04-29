tool
extends Node2D

export (int) var startWidth = 30 setget setStartWidth
export (int) var endWidth = 40 setget setEndWidth
export (int) var startJitter = 5 setget setStartJitter
export (int) var endJitter = 5 setget setEndJitter

var widthMarker1
var widthMarker2
var percOfMarker1

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("River")

func updateWidth(caller):
	if caller in [widthMarker1, widthMarker2]:
		var w1 = widthMarker1.position.x
		var w2 = widthMarker2.position.x
		var w1w = (w1 * percOfMarker1 + w2 * (100 - percOfMarker1)) / 100
		var w2w = (w1 * (percOfMarker1 - 10) + w2 * (110 - percOfMarker1)) / 100
		setStartWidth (w1w)
		setEndWidth (w2w)

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
	var newPolygon
	if has_node("LeftBank"):
		newPolygon = $LeftBank/Grass.polygon
		newPolygon.set(1,Vector2(max(startWidth, 16) + startJitter, 0))
		newPolygon.set(2,Vector2(max(endWidth, 16) + endJitter, 4))
		$LeftBank/Grass.set("polygon", newPolygon)
		newPolygon.set(1,Vector2(max(startWidth, 16) - startJitter, 0))
		newPolygon.set(2,Vector2(max(endWidth, 16) - endJitter, 4))
		$RightBank/Grass.set("polygon", newPolygon)
		var activeCollider
		for b in [$RightBank, $LeftBank]:
			var deltaWidth = b.get_node("Grass").polygon[1].x - b.get_node("Grass").polygon[2].x
			if abs(deltaWidth) < 3:
				activeCollider = b.get_node("Coll_I")
			else:
				activeCollider = b.get_node("Coll_L" if deltaWidth > 0 else "Coll_R")
			activeCollider.position.x = b.get_node("Grass").polygon[1].x
			for n in b.get_children():
				if n.get_class() == "CollisionPolygon2D":
					n.disabled = (n != activeCollider) 
					n.visible = (n == activeCollider)
			
	if has_node("Island"):
		if startWidth <= 0 && endWidth <= 0:
			newPolygon = $Island.polygon
			newPolygon.set(0, Vector2(startWidth + startJitter, 0))
			newPolygon.set(1, Vector2(-startWidth + startJitter, 0))
			newPolygon.set(2, Vector2(-endWidth + endJitter, 4))
			newPolygon.set(3, Vector2(endWidth + endJitter, 4))
			$Island.set("polygon", newPolygon)
			$Island.visible = true
		else:
			$Island.visible = false
			
