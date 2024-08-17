extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

@export var increase_vector : Vector2
@export var decrease_vector : Vector2
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	move_and_slide()
	
	if  Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		_increase_size()
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT):
		_decrease_size()



func _increase_size():
	scale += increase_vector
	print("i am increasing")
	pass
	

func _decrease_size():
	scale -= decrease_vector
	print("i am decreasing")
	pass
	
	


