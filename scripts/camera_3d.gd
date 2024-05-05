extends Camera3D

@onready var player = $"../Player"

@export_range(0.0, 20.0) var SPEED: float = 5.0 
var target = Vector3()

func _physics_process(delta):
	update_camera_position(delta)
	pass

func update_camera_position(delta):
	target = player.global_position
	var adjusted_target = Vector3(target.x, 2, target.z + 5)
	global_position = lerp(global_position, adjusted_target, delta * SPEED)
	pass

