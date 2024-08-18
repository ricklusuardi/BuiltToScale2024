extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (Input.is_action_just_pressed("pause")):
		get_tree().paused = false
		queue_free()


func _on_item_list_item_selected(index):
	if (index == 0):
		get_tree().paused = false
		queue_free()
	if (index == 1):
		get_tree().paused = false
		get_tree().change_scene_to_file("res://MainMenu.tscn")
	if (index == 2):
		get_tree().quit() 
