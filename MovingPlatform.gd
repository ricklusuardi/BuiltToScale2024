extends Node2D

@onready var playerRef = get_tree().get_nodes_in_group("MainCharacterGroup")[0]

# Called when the node enters the scene tree for the first time.
func _ready():
	$MovingPlatform/PathFollow2D.progress_ratio = 0.5
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_body_entered(body):
	
	if (body == playerRef):
		print("character is on the platform")
