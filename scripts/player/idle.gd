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

func enter(_msg := {}) -> void:
	last_direction = player.last_direction

	#	animation
	player.sprite.animation = 'idle'
	player.sprite.stop()
	player.sprite.frame = idle_frames[player.get_quarter(last_direction)] 

	# particles
	player.footstep_particles.emitting = false


func update(_delta: float) -> void:
	# transition
	if Input.is_action_just_pressed("melee"):
		state_machine.transition_to("Melee")

	if Input.get_vector("move_left", "move_right", "move_up", "move_down") != Vector2.ZERO:
		if Input.is_action_pressed("sprint"):
			state_machine.transition_to("Sprint")
		else:
			state_machine.transition_to("Walk")
	
func physics_update(delta: float) -> void:
	player.velocity	= lerp(player.velocity, Vector3.ZERO, player.FRICTION * delta)	
	# player.move_and_slide()
