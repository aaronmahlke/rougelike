extends PlayerState

@export_range(0.0, 20.0)
var MAX_WALK_SPEED: float = 1.0 

var animation_name:	String = ""
var last_direction:	Vector3 = Vector3.LEFT
var STEP_DELAY:	float = 0.3
var step_timer:	float = 0.0

func enter(_msg := {}) -> void:
	player.footstep_particles.emitting = true

func physics_update(delta: float) -> void:
	var direction = player.get_direction()
	if direction != Vector3.ZERO: 
		last_direction = direction

	# movement
	player.velocity += ( direction * player.ACCELLERATION * delta)
	player.velocity = player.velocity.limit_length(MAX_WALK_SPEED)
	player.move_and_slide()

	# animation
	var direction_name = player.get_quarter(direction)
	if direction_name != "idle":
		animation_name = "walk-" + direction_name 
		player.play_animation(animation_name)

	# sound
	step_timer -= delta
	if step_timer <= 0.0:
		player.footstep_sounds.play()
		step_timer = STEP_DELAY


	# transition
	if Input.is_action_just_pressed("sprint"):
		state_machine.transition_to("Sprint")

	if Input.is_action_just_pressed("dash"):
		state_machine.transition_to("Dash", {"last_direction": last_direction })
	elif direction == Vector3.ZERO: 
		state_machine.transition_to("Idle", {"last_direction": last_direction })

func exit() -> void:
	player.footstep_particles.emitting = false
	pass
