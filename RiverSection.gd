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
	if has_node("LeftBank"):
		var p = $LeftBank/Grass.polygon
		p.set(1,Vector2(max(startWidth, 16) + startJitter, 0))
		p.set(2,Vector2(max(endWidth, 16) + endJitter, 4))
		$LeftBank/Grass.set("polygon", p)
		p.set(1,Vector2(max(startWidth, 16) - startJitter, 0))
		p.set(2,Vector2(max(endWidth, 16) - endJitter, 4))
		$RightBank/Grass.set("polygon", p)
		for b in [$RightBank, $LeftBank]:
			var s = b.get_node("Grass").polygon
			s.set(0, Vector2(s[1].x-6,0))
			s.set(3, Vector2(s[2].x-6,4))
			b.get_node("Collider").set("polygon", s)
			
	if has_node("Island"):
		if startWidth <= 0 && endWidth <= 0:
			var p = $Island/Grass.polygon
			p.set(0, Vector2(startWidth + startJitter, 0))
			p.set(1, Vector2(-startWidth + startJitter, 0))
			p.set(2, Vector2(-endWidth + endJitter, 4))
			p.set(3, Vector2(endWidth + endJitter, 4))
			$Island/Grass.set("polygon", p)
			$Island.visible = true
			p.set(0, Vector2(p[1].x-6,0))
			p.set(3, Vector2(p[2].x-6,4))
			$Island/RightCollider.set("polygon", p)
			p = $Island/Grass.polygon
			p.set(1, Vector2(p[0].x+6,0))
			p.set(2, Vector2(p[3].x+6,4))
			$Island/LeftCollider.set("polygon", p)		
		else:
			$Island.visible = false
			
