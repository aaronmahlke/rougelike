extends Node
class_name HealthComponent

@export
var MAX_HEALTH : float = 10
var health : float 
var CLEANUP_TIME:float = 1
var cleanup_timer:float = 0
var ready_for_cleanup = false

@export
var death_particle_component : ParticleComponent

@export
var damage_particle_component : ParticleComponent

@export
var damage_audio_component : AudioStreamPlayer3D

@export
var death_audio_component : AudioStreamPlayer3D

@export
var visual: Node3D

func _ready():
	cleanup_timer = CLEANUP_TIME
	health = MAX_HEALTH
	if death_particle_component:
		death_particle_component.finished.connect(cleanup)
		
func _process(delta):
	if ready_for_cleanup:
		cleanup_timer -= delta
	if cleanup_timer <= 0:
		die()
	

func damage(attack: Attack):
	health -= attack.damage
	print(health)
	
	if damage_audio_component:
		damage_audio_component.play()
	
	if damage_particle_component:
		damage_particle_component.emitting = true

	if health <= 0:
		if death_audio_component:
			death_audio_component.play()
		if death_particle_component and visual:
			visual.visible = false
			death_particle_component.emitting = true
			
		else:
			cleanup()

func cleanup():
	
	ready_for_cleanup = true
	
func die():
	get_parent().queue_free()
