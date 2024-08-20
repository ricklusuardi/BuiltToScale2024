extends Node2D

@onready var node_starting_position =$".".global_position
@onready var starting_position: float = $Platform.global_position.y
var object: Chara
var platform_was_pressed_dowm = false
@export var spring_compression_rate: float = 10.0 # The higher the value, the faster the compression
@export var spring_decompression_rate: float = 10.0 # Use this to control the spring's decompression speed
@export var spring_jump_modifier: float = 4.0 # Use this to modify the jump
@onready var end_position = %EndPoint.global_position.y

func _process(delta: float) -> void:
	if object != null:
		if object.currentMass == 4.0:
			print("sei grasso perso")
			# Compress the platform
			global_position.y = move_toward(global_position.y,end_position, delta * spring_compression_rate)
		elif object.currentMass == 0.25:
			# Decompress the platform and launch the character
			global_position.y= move_toward(global_position.y,starting_position, delta * spring_decompression_rate)
			if global_position == node_starting_position :
					object.spring_jump(spring_jump_modifier)
		elif object.currentMass == 1.0:
			global_position.y = move_toward(global_position.y,starting_position,delta*spring_decompression_rate)
			pass
	if object == null :
		global_position.y = move_toward(global_position.y,starting_position,delta*spring_decompression_rate)
		pass

func _on_area_2d_body_entered(body: Node) -> void:
	if body is Chara:
		object = body

func _on_area_2d_body_exited(body: Node) -> void:
	if body is Chara:
		object = null
