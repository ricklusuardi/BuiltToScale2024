extends Area2D
class_name WindArea



@onready var character :Chara = %Character

func _ready():
	connect("body_entered", _on_body_entered)
	connect("body_exited", _on_body_exited)
	

func _on_body_entered(body):
	if body == character :
		character.in_wind()
		#TODO usare velocity
		print("ciao")


func _on_body_exited(body):
	if body == character :
		#TODO usare velocity
		character.not_in_wind()
		
