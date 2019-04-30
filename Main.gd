tool
extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	if Engine.editor_hint:
		var m = $LevelEditor
		for i in range(0,m.get_child_count()-1):
			var m1 = m.get_child(i)
			var m2 = m.get_child(i+1)
			for j in range (i*10, i*10+10):
				$Level.get_child(j).widthMarker1 = m1
				$Level.get_child(j).widthMarker2 = m2