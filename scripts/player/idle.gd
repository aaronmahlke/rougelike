extends PlayerState

var idle_frames = {
	'idle': 0,
	'n': 2,
	'ne': 1,
	'e': 0,
	'se': 7,
	's': 6,
	'sw': 5,
	'w': 4,
	'nw': 3
}

var last_direction = Vector3.ZERO

func get_idle_frame(direction: Vector3) -> int:
	print("get_idle_frame")
	print(direction)
	if direction == Vector3.ZERO:
		return idle_frames['idle']
	if direction.x == 0:
		if direction.y > 0:
			return idle_frames['n']
		else:
			return idle_frames['s']
	if direction.y == 0:
		if direction.x > 0:
			return idle_frames['e']
		else:
			return idle_frames['w']
	if direction.x > 0:
		if direction.y > 0:
			return idle_frames['ne']
		else:
			return idle_frames['se']
	else:
		if direction.y > 0:
			return idle_frames['nw']
		else:
			return idle_frames['sw']


func enter(_msg := {}) -> void:
	if "last_direction" in _msg:
		last_direction = _msg.last_direction

	#	animation
	player.sprite.animation = 'idle'
	player.sprite.stop()
	player.sprite.frame = idle_frames[player.get_quarter(last_direction)] 

	# particles
	player.footstep_particles.emitting = false


func update(_delta: float) -> void:
	# transition
	if Input.get_vector("move_left", "move_right", "move_up", "move_down") != Vector2.ZERO:
		if Input.is_action_pressed("sprint"):
			state_machine.transition_to("Sprint")
		else:
			state_machine.transition_to("Walk")
	
func physics_update(delta: float) -> void:
	player.velocity	= lerp(player.velocity, Vector3.ZERO, player.FRICTION * delta)	
	player.move_and_slide()
