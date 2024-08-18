extends CharacterBody2D
class_name Chara

var SPEED = 200.0
@export var in_wind_speed = 50
var is_in_wind = false
var wind_direction = Vector2.ZERO

# SCALE
@export var scaleChange: Vector2  # how much the size of the character increases/decreases
@export var currentScaleStep: int = 0  # keeps track of how many times the character has been scaled up or down
@export var maxScaleUp: int = 2  # max amount of times it can be scaled up
@export var minScaleDown: int = -2  # max amount of times it can be scaled down

# MASS
var baseMass = 1
var currentMass = baseMass
@export var massChange: float  # how much the mass of the character increases/decreases

# ANIMATION
var animRunMultiplier = 3  # how much quicker the animation should be when running
var animIdleMultiplier = 1
var currentAnimScale = 1
var animScaleMultiplier = 1.5  # how much quicker/slower the animations should be when sizes change

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	randomize()

func _physics_process(delta):
	print(currentMass)
	if is_in_wind:
		apply_wind_effect(delta)
	else:
		SPEED = 200.0

	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	# MOVEMENT
	if direction:
		velocity.x = direction * SPEED
		$AnimationPlayer.play("RobotRun")
		$AnimationPlayer.speed_scale = animRunMultiplier * currentAnimScale
		if velocity.x > 0:
			$Sprite2D.flip_h = false
		elif velocity.x < 0:
			$Sprite2D.flip_h = true
	else:
		# If standing still, let the wind move the character
		if is_in_wind:
			velocity.x += (wind_direction.x * (in_wind_speed/currentMass) * delta)
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
		
		$AnimationPlayer.play("RobotIdle")
		$AnimationPlayer.speed_scale = animIdleMultiplier * currentAnimScale

	if Input.is_action_just_pressed("ui_increase_size"):
		_increase_size()
	if Input.is_action_just_pressed("ui_decrease_size"):
		_decrease_size()

	# Process movement
	move_and_slide()

func _increase_size():
	if currentScaleStep < maxScaleUp:
		scale *= scaleChange
		currentMass *= massChange
		currentScaleStep += 1
		currentAnimScale /= animScaleMultiplier  # anim is slower when char is bigger
		$AudioStreamPlayerSizeDown.pitch_scale -= 0.2
		$AudioStreamPlayerSizeUp.pitch_scale -= 0.2
		$AudioStreamPlayerSizeUp.play()

func _decrease_size():
	if currentScaleStep > minScaleDown:
		scale /= scaleChange
		currentMass /= massChange
		currentScaleStep -= 1
		currentAnimScale *= animScaleMultiplier  # anim is faster when char is smaller
		$AudioStreamPlayerSizeDown.pitch_scale += 0.2
		$AudioStreamPlayerSizeUp.pitch_scale += 0.2
		$AudioStreamPlayerSizeDown.play()

# Adjust the speed based on the wind direction and character movement
func apply_wind_effect(delta: float):
	var direction = Input.get_axis("ui_left", "ui_right")

	if direction != 0:
		if (direction > 0 and wind_direction == Vector2.LEFT) or (direction < 0 and wind_direction == Vector2.RIGHT):
			# Slow down against the wind
			SPEED = max(SPEED - (in_wind_speed/currentMass), 50)
		elif (direction < 0 and wind_direction == Vector2.LEFT) or (direction > 0 and wind_direction == Vector2.RIGHT):
			# Speed up with the wind
			SPEED = min(SPEED + (in_wind_speed/currentMass), 400)
	else:
		# If standing still, the wind effect is handled in _physics_process
		pass

# Called when the character enters the wind area
func in_wind(wind_vector: Vector2):
	is_in_wind = true
	wind_direction = wind_vector

# Called when the character exits the wind area
func not_in_wind():
	is_in_wind = false
	wind_direction = Vector2.ZERO
