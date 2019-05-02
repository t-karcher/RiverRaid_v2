tool
extends EditorScript

const MAX_WIDTH = 120
const MIN_WIDTH = 10

var section_scene = preload("res://RiverSection.tscn")
var marker_scene = preload("res://WidthMarker.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _run():
	fixStartJitter()
	#deleteAll()
	#addRiverSections()

func deleteAll():
	for n in get_scene().get_node("Level").get_children():
		get_scene().get_node("Level").remove_child(n)
		n.free()
	for n in get_scene().get_node("LevelEditor").get_children():
		get_scene().get_node("LevelEditor").remove_child(n)
		n.free()

func reconnectMarkers():
	var m = get_scene().get_node("LevelEditor")
	for i in range(0,m.get_child_count()-1):
		var m1 = m.get_child(i)
		var m2 = m.get_child(i+1)
		for j in range (i*10, i*10+10):
			get_scene().get_node("Level").get_child(j).widthMarker1 = m1
			get_scene().get_node("Level").get_child(j).widthMarker2 = m2
			
func fixStartJitter():
	var m = get_scene().get_node("Level")
	for i in range(0,m.get_child_count()-1):
		var m1 = m.get_child(i)
		var m2 = m.get_child(i+1)
		m2.startJitter = m1.endJitter
	

func addRiverSections():
	var startWidth = 50
	var endWidth = 50
	var startJitter = 0
	var endJitter = 5
	var percOf1 = 100
	var m2 = marker_scene.instance()
	get_scene().get_node("LevelEditor").add_child(m2)
	m2.set_owner(get_scene())
	var m1
	for y in range(0,100):
		if y % 10 == 0:
			m1 = m2
			m2 = marker_scene.instance()
			m2.origY = (y + 10) * 4
			get_scene().get_node("LevelEditor").add_child(m2)
			m2.set_owner(get_scene())
			percOf1 = 100
		var section = section_scene.instance()
		section.position.y = y * 4
		section.startWidth = startWidth
		section.endWidth = endWidth
		section.startJitter = startJitter
		section.endJitter = endJitter
		section.widthMarker1 = m1
		section.widthMarker2 = m2
		section.percOfMarker1 = percOf1
		percOf1 -= 10
		get_scene().get_node("Level").add_child(section)
		section.set_owner(get_scene())
		section.add_to_group("River")
		startWidth = endWidth
		startJitter = endJitter
		endJitter = (randi() % 11) - 5
		if (randf() > .3): endWidth += (randi() % 11) - 5
		if endWidth > MAX_WIDTH: endWidth = MAX_WIDTH
		if endWidth < MIN_WIDTH: endWidth = MIN_WIDTH
		
