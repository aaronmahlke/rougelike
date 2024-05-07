extends PlayerState

@export_range(0.0, 20.0)
var MAX_SPRINT_SPEED: float = 2.0 

var animation_name:	String = ""
var last_direction:	Vector3 = Vector3.LEFT

func enter(_msg := {}) -> void:
	player.footstep_particles.emitting = true

func physics_update(delta: float) -> void:
	var direction = player.get_direction()
	player.velocity += ( direction * player.ACCELLERATION * delta)
	player.velocity = player.velocity.limit_length(MAX_SPRINT_SPEED)
	player.move_and_slide()

	if direction != Vector3.ZERO: 
		last_direction = direction

	# animation
	animation_name = "sprint-" + player.get_quarter(direction)
	player.play_animation(animation_name)

	if Input.is_action_just_released("sprint"):
		state_machine.transition_to("Walk")

	if Input.is_action_just_pressed("dash"):
		state_machine.transition_to("Dash", {"last_direction": last_direction })
	elif direction == Vector3.ZERO: 
		state_machine.transition_to("Idle", {"last_direction": last_direction })


func exit() -> void:
	player.footstep_particles.emitting = false
	pass
