extends Node
class_name HealthComponent

@export
var MAX_HEALTH : float = 10
var health : float 

@export
var death_particle_component : ParticleComponent

@export
var	sprite: Sprite3D

func _ready():
	health = MAX_HEALTH
	if death_particle_component:
		death_particle_component.finished.connect(die)

func damage(attack: Attack):
	health -= attack.damage

	if health <= 0:
		if death_particle_component and sprite:
			if sprite != null:
				sprite.queue_free()
			death_particle_component.emitting	= true
		else:
			die()

func die():
	get_parent().queue_free()
