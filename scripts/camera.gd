extends Camera2D

@onready var player = $"../Player"

var target = Vector2()
const SPEED = 10.0

func _physics_process(delta):
	target = player.global_position
	global_position = lerp(global_position, target, delta * SPEED)


