extends CharacterBody2D
class_name Chara

var SPEED = 200.0
#const JUMP_VELOCITY = -400.0

@export var scaleChange : Vector2 #how much the size of the character increases/decreases
@export var currentScaleStep : int = 0 # keeps track of how many times the character has been scaled up or down. 
@export var maxScaleUp : int = 2 # max amount of times it can be scaled up
@export var minScaleDown : int = - 2 # max amount of times it can be scaled down
var is_in_wind = false
@export var in_wind_speed = 50
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	randomize()

func _physics_process(delta):
	if is_in_wind:
		SPEED = in_wind_speed 
	else :
		SPEED = 200.0
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta


	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	#MOVEMENT
	if direction:
		velocity.x = direction * SPEED
		$AnimationPlayer.play("RobotRun")
		$AnimationPlayer.speed_scale = 2
		#$AudioStreamPlayer.pitch_scale = randf_range(0.9, 1.1)
		if velocity.x > 0:
			$Sprite2D.flip_h = false
		elif velocity.x < 0:
			$Sprite2D.flip_h = true
	else:
		#IDLE
		velocity.x = move_toward(velocity.x, 0, SPEED)
		$AnimationPlayer.play("RobotIdle")
		$AnimationPlayer.speed_scale = 1
		
		
	if Input.is_action_just_pressed("ui_increase_size"):
		_increase_size()
	if Input.is_action_just_pressed("ui_decrease_size"):
		_decrease_size()

	move_and_slide()

func _increase_size():
	if (currentScaleStep < maxScaleUp):
		scale *= scaleChange
		currentScaleStep += 1

func _decrease_size():
	if (currentScaleStep > minScaleDown):
		scale /= scaleChange
		currentScaleStep -= 1

func in_wind():
	is_in_wind = true

func not_in_wind():
	is_in_wind =  false
