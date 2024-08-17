extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if Input.is_action_just_pressed("ui_character_size_increase"):
		
		if (scale < Vector2(8,8)):
			scale *= 2

	if Input.is_action_just_pressed("ui_character_size_decrease"):
		if (scale > Vector2(0.25, 0.25)):
			scale /= 2
	
	pass

