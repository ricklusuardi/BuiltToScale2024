extends Node2D

@onready var playerRef = get_tree().get_nodes_in_group("MainCharacterGroup")[0]

var playerOnPlatform = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$MovingPlatform/PathFollow2D.progress_ratio = 0.5
	playerRef.size_changed.connect("_on_size_changed")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_body_entered(body):
	
	if (body == playerRef):
		print("character is on the platform: ", playerRef.currentMass)
		
		if (playerRef.currentScaleStep == 1):
			$MovingPlatform/PathFollow2D.progress_ratio = 0.25
		if (playerRef.currentScaleStep == 2):
			$MovingPlatform/PathFollow2D.progress_ratio = 0.0
			
		playerOnPlatform = true


func _on_area_2d_body_exited(body):
	
	if ($MovingPlatform/PathFollow2D.progress_ratio <= 0):
		$MovingPlatform/PathFollow2D.progress_ratio = 0
	
	playerOnPlatform = false


func _react_to_weight_change(playerMass : int):
	
	if ($MovingPlatform/PathFollow2D.progress_ratio >= 0.5):
		if (playerMass == 1):
			$MovingPlatform/PathFollow2D.progress_ratio = 0.25
		elif (playerMass == 2):
			$MovingPlatform/PathFollow2D.progress_ratio = 0.00
	
	elif($MovingPlatform/PathFollow2D.progress_ratio == 0.25):
		if (playerMass == 2):
			$MovingPlatform/PathFollow2D.progress_ratio = 0.00
		elif (playerMass == 0):
			$MovingPlatform/PathFollow2D.progress_ratio = 0.5
		elif (playerMass == -1):
			$MovingPlatform/PathFollow2D.progress_ratio = 0.6
		elif (playerMass == -2):
			$MovingPlatform/PathFollow2D.progress_ratio = 0.75
	
	elif($MovingPlatform/PathFollow2D.progress_ratio == 0.0):
		if (playerMass == 1):
			$MovingPlatform/PathFollow2D.progress_ratio = 0.25
		if (playerMass == 0):
			$MovingPlatform/PathFollow2D.progress_ratio = 0.5
		if (playerMass == -1):
			$MovingPlatform/PathFollow2D.progress_ratio = 0.75
		if (playerMass == -2):
			$MovingPlatform/PathFollow2D.progress_ratio = 1.0

func _on_size_changed():
	if playerOnPlatform:
		_react_to_weight_change(playerRef.currentScaleStep)
