tool
extends Position2D

export(int) var origY = 0

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
	if is_inside_tree() && (what == NOTIFICATION_TRANSFORM_CHANGED):
		position.y = origY
		get_tree().call_group("River", "updateWidth", self)
