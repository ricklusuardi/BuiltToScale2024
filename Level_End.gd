extends Area2D

@export var win_screen : PackedScene

func _on_body_entered(body):
	if body is Chara:  
		call_deferred("_change_scene")


func _change_scene():
	get_tree().change_scene_to_packed(win_screen)

