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

func updateWidth():
	if is_instance_valid(widthMarker1) && is_instance_valid(widthMarker2):
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
		newPolygon = $LeftBank.polygon
		newPolygon.set(1,Vector2(max(startWidth, 16) + startJitter, 0))
		newPolygon.set(2,Vector2(max(endWidth, 16) + endJitter, 4))
		$LeftBank.set("polygon", newPolygon)
		newPolygon.set(1,Vector2(max(startWidth, 16) - startJitter, 0))
		newPolygon.set(2,Vector2(max(endWidth, 16) - endJitter, 4))
		$RightBank/RightGrass.set("polygon", newPolygon)
		var deltaWidth = newPolygon[1].x - newPolygon[2].x
		var activeCollider
		if abs(deltaWidth) < 3:
			activeCollider = $RightBank/RightColl_I
		elif deltaWidth > 0:
			activeCollider = $RightBank/RightColl_L
		else:
			activeCollider = $RightBank/RightColl_R
		activeCollider.position.x = newPolygon[1].x
		$RightBank/RightColl_I.disabled = ($RightBank/RightColl_I != activeCollider) 
		$RightBank/RightColl_L.disabled = ($RightBank/RightColl_L != activeCollider)
		$RightBank/RightColl_R.disabled = ($RightBank/RightColl_R != activeCollider)		
		$RightBank/RightColl_I.visible = ($RightBank/RightColl_I == activeCollider) 
		$RightBank/RightColl_L.visible = ($RightBank/RightColl_L == activeCollider)
		$RightBank/RightColl_R.visible = ($RightBank/RightColl_R == activeCollider)		
		
			
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
			
