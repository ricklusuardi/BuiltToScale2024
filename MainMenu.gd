extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



#func _on_play_button_button_down():
	#get_tree().change_scene_to_file("res://world.tscn")

func _on_item_list_item_clicked(index, at_position, mouse_button_index):
	if (index == 0):
		get_tree().change_scene_to_file("res://world.tscn")
	elif (index == 1):
		$LevelSelect.visible = true
	elif (index ==2):
		get_tree().change_scene_to_file("res://credits_menu.tscn")
	elif (index ==2):
		get_tree().quit()
		


func _on_level_select_item_clicked(index, at_position, mouse_button_index):
	if (index == 0):
		get_tree().change_scene_to_file("res://world.tscn")
	elif (index == 1):
		pass
	elif (index ==2):
		pass



