extends Area2D

var chara_ref : Chara
@export var spike_dmg := 1


func _on_body_entered(body):
	if body is Chara:
		body._get_damaged(spike_dmg)

