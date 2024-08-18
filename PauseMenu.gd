extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (Input.is_action_just_pressed("pause")):
		get_tree().paused = false
		queue_free()


func _on_item_list_item_clicked(index, at_position, mouse_button_index):
	if (index == 0):
		$Timer.start()
	if (index == 1):
		get_tree().paused = false
		get_tree().change_scene_to_file("res://MainMenu.tscn")
	if (index == 2):
		get_tree().quit() 



func _on_timer_timeout():
	get_tree().paused = false
	queue_free()
