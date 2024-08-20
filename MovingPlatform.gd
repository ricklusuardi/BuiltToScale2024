extends Node2D

@onready var playerRef = get_tree().get_nodes_in_group("MainCharacterGroup")[0]

var playerOnPlatform = false
var isMoving = false
var targetRatio = 0.0
var speed = 0.3

# Called when the node enters the scene tree for the first time.
func _ready():
	$MovingPlatform/PathFollow2D.progress_ratio = 0.5
	playerRef.scale_changed.connect(_on_size_changed)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#print("target ratio: ", targetRatio)
	print("is moving: ", isMoving)
	#$MovingPlatform/PathFollow2D.progress_ratio += 0.03
	print("progress ratio: ", $MovingPlatform/PathFollow2D.progress_ratio)
	
	if isMoving:
		if ($MovingPlatform/PathFollow2D.progress_ratio < targetRatio):
			$MovingPlatform/PathFollow2D.progress_ratio += speed
		elif ($MovingPlatform/PathFollow2D.progress_ratio > targetRatio):
			$MovingPlatform/PathFollow2D.progress_ratio -= speed
	else: 
		if ($MovingPlatform/PathFollow2D.progress_ratio < 0.5):
			$MovingPlatform/PathFollow2D.progress_ratio += speed
		elif ($MovingPlatform/PathFollow2D.progress_ratio > 0.5):
			$MovingPlatform/PathFollow2D.progress_ratio -= speed
	


func _on_area_2d_body_entered(body):
	
	
	if (body == playerRef):
		print("body entered")
		if (playerRef.currentScaleStep == 1):
			isMoving = true
			targetRatio = 0.25
		if (playerRef.currentScaleStep == 2):
			isMoving = true
			targetRatio = 0.0
		
		playerOnPlatform = true

#
func _on_area_2d_body_exited(body):
	
	if ($MovingPlatform/PathFollow2D.progress_ratio <= 0):
		$MovingPlatform/PathFollow2D.progress_ratio = 0
	
	playerOnPlatform = false


func _react_to_weight_change(playerMass : int):
	
	if ($MovingPlatform/PathFollow2D.progress_ratio == 0.5):
		if (playerMass == 1):
			isMoving = true
			targetRatio = 0.25
		elif (playerMass == 2):
			isMoving = true
			targetRatio = 0.00
	
	elif(0.25 == $MovingPlatform/PathFollow2D.progress_ratio):
		if (playerMass == 2):
			isMoving = true
			targetRatio = 0.00
		elif (playerMass == 0):
			isMoving = true
			targetRatio = 0.5
		elif (playerMass == -1):
			isMoving = true
			targetRatio = 0.6
		elif (playerMass == -2):
			isMoving = true
			targetRatio = 0.75
	
	elif(0.0 == $MovingPlatform/PathFollow2D.progress_ratio):
		if (playerMass == 1):
			isMoving = true
			targetRatio = 0.25
		if (playerMass == 0):
			isMoving = true
			targetRatio = 0.5
		if (playerMass == -1):
			isMoving = true
			targetRatio = 0.75
		if (playerMass == -2):
			isMoving = true
			targetRatio = 1.0

func _on_size_changed():
	if playerOnPlatform:
		_react_to_weight_change(playerRef.currentScaleStep)
