extends CharacterBody3D

@onready var player_sprite = $Sprite
@onready var footstep_particles = $FootstepParticles

@export_range(0.0, 20.0) var MAX_SPEED: float = 2.0 
@export_range(0, 40.0) var MAX_SPRINT_SPEED = 4.0
@export_range(0, 100.0) var ACCELLERATION = 10
@export_range(0, 200.0)var FRICTION = 20

var last_direction = Vector3.ZERO
var state = "idle"

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

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")


func _physics_process(delta):
	move_player(delta)
	update_anim()

func move_player(delta):
	var input_dir = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	var is_sprinting = Input.is_action_pressed("sprint")

	if direction == Vector3.ZERO:
		state = 'idle'
		if velocity.length() > (FRICTION * delta):
			velocity -= velocity.normalized() * (FRICTION * delta)
		else:
			velocity = Vector3.ZERO
	else:
		last_direction = direction
		if is_sprinting:
			state = 'sprint-' + get_quarter(direction)
			velocity += (direction * ACCELLERATION * delta)
			velocity = velocity.limit_length(MAX_SPRINT_SPEED)
		else:
			state = 'walk-' + get_quarter(direction)
			velocity += (direction * ACCELLERATION * delta)
			velocity = velocity.limit_length(MAX_SPEED)

	move_and_slide()

func update_anim():
	if state == 'idle':
		player_sprite.animation = 'idle'
		player_sprite.stop()
		player_sprite.frame = idle_frames[get_quarter(last_direction)]
		footstep_particles.emitting = false
	else:
		if player_sprite.animation != state:
			player_sprite.animation = state
			player_sprite.play()
			footstep_particles.emitting = true

	
func get_quarter(dir) -> String:
	if dir.x < 0:
		if dir.z < 0:
			return 'nw'
		elif dir.z > 0:
			return 'sw'
		else:
			return 'w'
	if dir.x > 0:
		if dir.z < 0:
			return 'ne'
		elif dir.z > 0:
			return 'se'
		else:
			return 'e'
	if dir.z < 0:
		return 'n'
	if dir.z > 0:
		return 's'
	return 'idle'
