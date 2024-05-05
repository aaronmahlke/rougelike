extends Camera2D

@onready var player = $"../Player"
@onready var cursor = $Cursor

var target = Vector2()
const SPEED = 10.0

func _physics_process(delta):
	update_camera_position(delta)

func update_camera_position(delta):
	target = player.global_position
	global_position = lerp(global_position, target, delta * SPEED)
	pass





