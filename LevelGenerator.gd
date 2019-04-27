tool
extends EditorScript

const MAX_WIDTH = 120
const MIN_WIDTH = 10

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _run():
	deleteAll()
	addRiverSection()

func deleteAll():
	for n in get_scene().get_node("Level").get_children():
		get_scene().get_node("Level").remove_child(n)
		n.free()
		
func addRiverSection():
	var startWidth = 50
	var endWidth = 50
	var startJitter = 0
	var endJitter = 5	
	for y in range(0,40,4):
		var section = preload("res://RiverSection.tscn").instance()
		section.position.y = y
		section.startWidth = startWidth
		section.endWidth = endWidth
		section.startJitter = startJitter
		section.endJitter = endJitter
		get_scene().get_node("Level").add_child(section)
		section.set_owner(get_scene())
		startWidth = endWidth
		startJitter = endJitter
		endJitter = (randi() % 11) - 5
		if (randf() > .3): endWidth += (randi() % 11) - 5
		if endWidth > MAX_WIDTH: endWidth = MAX_WIDTH
		if endWidth < MIN_WIDTH: endWidth = MIN_WIDTH
		
