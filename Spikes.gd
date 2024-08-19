extends Area2D

var chara_ref : Chara
@export var spike_dmg := 1


func _on_body_entered(body:Chara):
	body._get_damaged(spike_dmg)
	pass # Replace with function body.
