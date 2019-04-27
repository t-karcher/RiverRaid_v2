tool
extends Position2D

export(int) var origY = 2

signal transform_changed

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	if Engine.editor_hint:
		visible = true
		set_notify_transform(true)
	else:
		visible = false

func _notification(what):
	position.y = origY
	emit_signal("transform_changed")
	
