extends Area2D
class_name WindArea

@onready var character: Chara 

# Define the enum for wind direction
enum WindDirection {
	LEFT,
	RIGHT
}

@export var wind_direction: WindDirection = WindDirection.LEFT  # The direction of the wind
#@export var wind_force: float = 50.0  # The force of the wind

# Returns the wind direction as a Vector2
func get_wind_vector() -> Vector2:
	match wind_direction:
		WindDirection.LEFT:
			return Vector2.LEFT
		WindDirection.RIGHT:
			return Vector2.RIGHT
	return Vector2.ZERO

# Called when a body enters the wind area
func _on_body_entered(body):
	if body is Chara:
		character = body
		var wind_vector = get_wind_vector()
		character.in_wind(wind_vector)

# Called when a body exits the wind area
func _on_body_exited(body):
	if body is Chara:
		character = body
		character.not_in_wind()
