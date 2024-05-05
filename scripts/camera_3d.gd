extends Camera3D

@onready var player = $"../Player"

const SPEED = 5.0
var target = Vector3()

func _physics_process(delta):
	update_camera_position(delta)
	pass

func update_camera_position(delta):
	target = player.global_position
	var adjusted_target = Vector3(target.x, 2, target.z + 1.67)
	global_position = lerp(global_position, adjusted_target, delta * SPEED)
	print(global_position)
	# look_at(target, Vector3.UP) 
	pass

