tool
extends Node2D

export (int) var startWidth = 30 setget setStartWidth
export (int) var endWidth = 40 setget setEndWidth
export (int) var startJitter = 5 setget setStartJitter
export (int) var endJitter = 5 setget setEndJitter

export (NodePath) var widthMarker1
export (NodePath) var widthMarker2
export (int) var percOfMarker1

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

# Update position of grass and colliders
# based on the nearest width markers
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
			$Island/RightCollider.disabled = false
			p = $Island/Grass.polygon
			p.set(1, Vector2(p[0].x+6,0))
			p.set(2, Vector2(p[3].x+6,4))
			$Island/LeftCollider.set("polygon", p)
			$Island/LeftCollider.disabled = false
		else:
			$Island.visible = false
			$Island/LeftCollider.disabled = true
			$Island/RightCollider.disabled = true
