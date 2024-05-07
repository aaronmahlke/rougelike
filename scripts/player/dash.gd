extends PlayerState

@export_range(0.0, 20.0)
var DASH_SPEED: float = 6.0 

@export_range(0.0, 0.8)
var DASH_DURATION: float = 0.2

var dash_timer: float = 0.0
var animation_name:	String = ""
var direction: Vector3 = Vector3.ZERO

func enter(_msg := {}) -> void:
	if "last_direction" in _msg:
		direction = _msg.last_direction

	dash_timer = DASH_DURATION

func physics_update(_delta: float) -> void:
	var dash_vector = direction * DASH_SPEED

	# movement
	player.velocity = dash_vector
	player.move_and_slide()

	# timer
	dash_timer -= _delta

	# animation
	animation_name = "dash-" + player.get_quarter(direction)
	player.play_animation(animation_name)

	# transition
	if dash_timer <= 0:
		state_machine.transition_to("previous")

