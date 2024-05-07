class_name Foliage
extends Area3D

@export
var DURATION:float = 1.0

var from_rotation = deg_to_rad(0)
var target_rotation = deg_to_rad(-90)
var parent = null
var elapsed_time = 0
var timer = 0.0
var colliding = false

func _ready():
	parent = get_parent()

func _process(delta):
	if colliding:
		var angle = lerp_angle(from_rotation, target_rotation, elapsed_time)
		parent.rotation = Vector3(angle, 0, 0)
		elapsed_time += delta
		timer	-= delta

		if timer <= DURATION / 2:
			from_rotation = deg_to_rad(-90)
			target_rotation = deg_to_rad(0)

		if timer <= 0:
			colliding = false
			elapsed_time = 0
			timer = 0.0

func _on_body_entered(body:Node3D):
	print(body.name)
	from_rotation = deg_to_rad(0)	
	target_rotation = deg_to_rad(-90)
	colliding = true
	timer	= 1.0


