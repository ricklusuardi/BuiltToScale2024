extends Area2D

func _on_body_entered(body:Chara):
	body.set_respawn_point(global_position)

