extends GPUParticles3D
class_name ParticleComponent

func _on_finished():
	get_parent().queue_free()
	pass # Replace with function body.

