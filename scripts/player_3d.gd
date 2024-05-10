class_name Player
extends CharacterBody3D

var quarters = ['n', 'ne', 'e', 'se', 's', 'sw', 'w', 'nw']

@export
var sprite: AnimatedSprite3D

@export
var footstep_particles: GPUParticles3D

@export
var attack_component: AttackComponent

var ACCELLERATION = 18
var FRICTION = 10

var last_direction = Vector3.RIGHT

func _ready():
	Global.player = self

func get_direction() -> Vector3:
	var input_dir = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	return direction

func play_animation(animation_name: String):
	if sprite.animation != animation_name:
		sprite.animation = animation_name
		sprite.play()

func get_quarter(dir: Vector3) -> String:
	var angle = (Vector3(0,0,-1).dot(dir) + 1) * 1.5
	if dir.x < 0 or dir.x <= 0 and dir.z > 0:
		if dir.x < 0:
			angle += 1
		angle += 4
		return quarters[floor(angle)]

	angle = 3 - angle
	return quarters[ceil(angle)]
	
func get_quarter_dep(dir) -> String:
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
