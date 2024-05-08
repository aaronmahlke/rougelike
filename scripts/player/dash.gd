extends PlayerState

@export_range(0.0, 20.0)
var DASH_SPEED: float = 4.0 

@export_range(0.0, 0.8)
var DASH_DURATION: float = 0.2

@export	
var audio: AudioStreamPlayer3D = null

var dash_timer: float = 0.0
var animation_name:	String = ""

@onready
var direction: Vector3 = Vector3.ZERO

func enter(_msg := {}) -> void:
	direction = player.last_direction
	if direction == Vector3.ZERO:
		state_machine.transition_to("Idle")
		return

	dash_timer = DASH_DURATION
	audio.play()

func physics_update(_delta: float) -> void:
	if direction == Vector3.ZERO:
		state_machine.transition_to("Idle")
		return
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

