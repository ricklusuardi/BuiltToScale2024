extends Node2D

var sizeUp = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	if sizeUp:
		$AnimationPlayer.play("SizeUp")
	else:
		$AnimationPlayer.play_backwards("SizeUp")
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



func _on_timer_timeout():
	queue_free()
