extends PlayerState

@export	
var audio: AudioStreamPlayer3D = null

@export
var MELEE_DURATION : float = 0.5

@export
var MELEE_SPEED : float = 1.0

var transition_speed	: float = 2.0
var timer	: float = 0.0
var direction : Vector3 = Vector3.ZERO
var offset : float = 0.1
var original_sprite_pos : Vector3 = Vector3.ZERO
var animation_name : String = ""

func enter(_msg := {}) -> void:
	timer	= MELEE_DURATION
	direction = player.last_direction
	player.attack_box.monitoring = true

	# animation
	animation_name = "melee-" + player.get_quarter(direction)
	player.play_animation(animation_name)

	# audio
	audio.play()

	# move sprite
	original_sprite_pos = player.sprite.position
	var global_offset = original_sprite_pos	+	Vector3(0, offset, 0)
	player.sprite.position = global_offset


func update(_delta: float) -> void:
	timer	-= _delta
	player.sprite.position = lerp(player.sprite.position, original_sprite_pos, _delta	* transition_speed )
	if timer <= 0.0:
		state_machine.transition_to("Idle")

func physics_update(_delta: float) -> void:
	var melee_vector	=	direction * MELEE_SPEED
	player.velocity = melee_vector
	player.move_and_slide()

func exit() -> void:
	player.attack_box.monitoring = false
	player.sprite.position = original_sprite_pos
