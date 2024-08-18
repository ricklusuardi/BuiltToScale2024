extends AnimatableBody2D

@onready var starting_pos = position
@onready var end_position = %EndPosition.position  # Ensure this points to the correct node in your scene
var is_on_pedana: bool = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	print(str(position))
	if is_on_pedana:
		position = position.move_toward(end_position, 100 * delta)  # Moves toward the end position
	else:
		position = position.move_toward(starting_pos, 100 * delta)  # Moves back to the starting position






func _on_area_2d_body_entered(body):
	if body is Chara:
		is_on_pedana = true



func _on_area_2d_body_exited(body):
	if body is Chara:
		is_on_pedana = false


