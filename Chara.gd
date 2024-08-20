extends CharacterBody2D
class_name Chara

var SPEED = 200.0
@export var in_wind_speed = 50
var is_in_wind = false
var wind_direction = Vector2.ZERO
var respawn_point: Vector2


#HEALTH
@export var maxHealth : int
var currentHealth = maxHealth

#JUMP
@export var jumpVelocity = -400
@export var jumpChange = 1.3
var jumpSpriteRef = preload("res://JumpFlame.tscn")


# SCALE
@export var scaleChange: Vector2  # how much the size of the character increases/decreases
@export var currentScaleStep: int = 0  # keeps track of how many times the character has been scaled up or down
@export var maxScaleUp: int = 1  # max amount of times it can be scaled up
@export var minScaleDown: int = -1  # max amount of times it can be scaled down

signal scale_changed

# MASS
var baseMass = 1
var currentMass = baseMass
@export var massChange: float  # how much the mass of the character increases/decreases

# ANIMATION
var animRunMultiplier = 3  # how much quicker the animation should be when running
var animIdleMultiplier = 1
var currentAnimScale = 1
var animScaleMultiplier = 1.5  # how much quicker/slower the animations should be when sizes change

#PARTICLES
var effectBaseValue = 0.5 #base scale of the particle
var effectSizeMultiplier = 2 #how much the part changes in size when the char changes
@export var particleType : PackedScene 

#CAMERA
var camOffsetLvl1 = 18 #keeps the camera centered when changing size
var camOffsetLvl2 = 13 #keeps the camera centered when changing size
var camZoomChange = Vector2(0.3, 0.3)

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _ready():
	randomize()

func _physics_process(delta):
	#print(currentMass)
	
	if is_in_wind:
		apply_wind_effect(delta)
	else:
		SPEED = 200.0

	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	_handle_jump()

	# MOVEMENT
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
		if is_on_floor():
			$AnimationPlayer.play("RobotRun")
			$AnimationPlayer.speed_scale = animRunMultiplier * currentAnimScale
		elif !is_on_floor():
			$AnimationPlayer.play("RobotIdle")
		if velocity.x > 0:
			$Sprite2D.flip_h = false
			$JumpFlamePoint.position.x = -5
			
		elif velocity.x < 0:
			$Sprite2D.flip_h = true
			$JumpFlamePoint.position.x = 5
			
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
	
	#Process movement
	move_and_slide()


#region SIZE
func _increase_size():
	if (currentScaleStep < maxScaleUp):
		
		currentMass *= massChange
		
		#change size
		scale *= scaleChange
		currentScaleStep += 1
		currentAnimScale /= animScaleMultiplier #anim is slower when char is bigger
		
		#play audio
		$AudioStreamPlayerSizeDown.pitch_scale -= 0.2
		$AudioStreamPlayerSizeUp.pitch_scale -= 0.2
		$AudioStreamPlayerSizeUp.play()
		
		#play animation
		var effect = particleType.instantiate()
		$Sprite2D.add_child(effect)
		
		#adjust camera
		if (currentScaleStep == 1):
			$Camera2D.position.y += camOffsetLvl1
		elif (currentScaleStep == 2):
			$Camera2D.position.y += camOffsetLvl2
		
		jumpVelocity *= jumpChange
		
		$Camera2D.zoom -= camZoomChange
		
		emit_signal("scale_changed")
		

func _decrease_size():
	if (currentScaleStep > minScaleDown):
		
		#adjust camera
		if (currentScaleStep == 1):
			$Camera2D.position.y -= camOffsetLvl1
		elif (currentScaleStep == 2):
			$Camera2D.position.y -= camOffsetLvl2
		
		currentMass /= massChange
		
		#change size
		scale /= scaleChange
		currentScaleStep -= 1
		currentAnimScale *= animScaleMultiplier #anim is faster when char is smaller
		
		#play audio
		$AudioStreamPlayerSizeDown.pitch_scale += 0.2
		$AudioStreamPlayerSizeUp.pitch_scale += 0.2
		$AudioStreamPlayerSizeDown.play()
		
		#play animation
		var effect = particleType.instantiate()
		$Sprite2D.add_child(effect)
		
		#change jump
		jumpVelocity /= jumpChange
		
		$Camera2D.zoom += camZoomChange
		
		emit_signal("scale_changed")
		
#endregion

#region WIND
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

#endregion

func _get_damaged(damage : int):
	
	currentHealth -= damage
	if (currentHealth <= 0):
		print("YOU DIED!")
		position =respawn_point
		
func set_respawn_point(point : Vector2):
	respawn_point = point

func _handle_jump():
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = jumpVelocity
		var jumpSprite = jumpSpriteRef.instantiate()
		$JumpFlamePoint.add_child(jumpSprite)

func spring_jump(spring_modifier):
	velocity.y = jumpVelocity * spring_modifier
