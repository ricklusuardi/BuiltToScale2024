extends Node2D

@onready var breaking_point := 1

func _on_blocchi_instabili_body_entered(body):
	if body is Chara:
		if body.currentMass == breaking_point:
			self.queue_free()
			#maybe add a animation?


func _on_blocchi_instabili_body_exited(body):
		if body is Chara:
			#stop animation
			pass

