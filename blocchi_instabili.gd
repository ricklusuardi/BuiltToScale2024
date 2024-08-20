extends Node2D


@onready var breaking_point := 1
var is_block_alive = true
var chara_ref : Chara
var blocco = preload("res://animatedstaticbody.tscn")


func _process(_delta):
	
	if chara_ref != null :
		if chara_ref.currentMass < breaking_point :
			%AnimationPlayer.stop()
		if chara_ref.currentMass > breaking_point :
			%AnimationPlayer.play("breaking_tile")

func _on_blocchi_instabili_body_entered(body):
	if body is Chara:
		if body.currentMass == breaking_point:
			print("ciao")
		chara_ref = body
		if body.currentMass > breaking_point:
			%AnimationPlayer.play("breaking_tile")



func _on_blocchi_instabili_body_exited(body):
		if body is Chara and is_block_alive== true :
			%AnimationPlayer.stop()

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "breaking_tile" :
		is_block_alive = false
		print("animation done")
		queue_free()
	pass # Replace with function body.
