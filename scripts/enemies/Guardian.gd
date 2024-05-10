extends RigidBody3D
class_name Enemy

@export
var MAX_SPEED = 2.0

@export
var ACCELLERATION = 2.0

@export
var FRICTION = 0.01

@export
var sprite: AnimatedSprite3D

@export
var attack_component: AttackComponent

# Called when the node enters the scene tree for the first time.
func _ready():
	sprite.animation = "idle"
	sprite.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
	
func _physics_process(delta):
	pass
	#linear_velocity = linear_velocity.limit_length(MAX_SPEED)
