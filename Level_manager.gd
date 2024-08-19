extends Node

@export var levels: Array[PackedScene] = []
@export var main_menu : PackedScene
var current_level_index: int = 0

func next_level():
	if levels.size() == 0:
		return
	
	current_level_index = wrap(current_level_index + 1, 0, levels.size() - 1)
	get_tree().change_scene_to_packed(levels[current_level_index])
	

func go_to_main_menu():
	get_tree().change_scene_to_packed(main_menu)
	pass

