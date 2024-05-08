extends Node
class_name HealthComponent

@export
var MAX_HEALTH : float = 10
var health : float 

@export
var particle_component : ParticleComponent

@export
var	sprite: Sprite3D

func _ready():
	health = MAX_HEALTH

func damage(attack: Attack):
	print("Damage: " + str(attack.damage))
	health -= attack.damage

	if health <= 0:
		if particle_component and sprite:
			sprite.queue_free()
			particle_component.emitting	= true
		else:
			get_parent().queue_free()

