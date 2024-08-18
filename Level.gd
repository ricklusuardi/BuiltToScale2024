extends Node2D

var menuRef = preload("res://PauseMenu.tscn")


@onready var canvasRef = get_tree().get_nodes_in_group("CanvasLayerGroup")[0]

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (Input.is_action_just_pressed("pause")):

		var pauseMenu = menuRef.instantiate()
		canvasRef.add_child(pauseMenu)
		get_tree().paused = true
