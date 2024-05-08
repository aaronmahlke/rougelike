class_name Player
extends CharacterBody3D

@onready
var sprite = $Sprite

@onready
var footstep_particles = $Footstep

@onready
var attack_box = $AttackBox

var ACCELLERATION = 18
var FRICTION = 10

var last_direction = Vector3.RIGHT

func get_direction() -> Vector3:
	var input_dir = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	return direction

func play_animation(animation_name: String):
	if sprite.animation != animation_name:
		sprite.animation = animation_name
		sprite.play()
	
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
