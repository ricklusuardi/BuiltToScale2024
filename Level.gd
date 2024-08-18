extends Node2D

var menuRef = preload("res://PauseMenu.tscn")

@onready var cameraRef = get_tree().get_nodes_in_group("CameraGroup")[0]

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (Input.is_action_just_pressed("pause")):
		var pauseMenu = menuRef.instantiate()
		add_child(pauseMenu)
		pauseMenu.position = cameraRef.position
		get_tree().paused = true
