extends Sprite

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	frame = 0
	if Input.is_action_pressed("ui_left"):
		frame = 1
		position.x -= 1
	if Input.is_action_pressed("ui_right"):
		frame = 2
		position.x += 1