extends Node
class_name KnockbackComponent

func knockback(attack: Attack):
	var parent_pos = get_parent().global_position
	var this_position = Vector3(parent_pos.x, 0, parent_pos.z)
	var attack_position = Vector3(attack.position.x, 0, attack.position.z)
	var direction = (this_position - attack_position).normalized()

	if get_parent() is RigidBody3D:
		print("jippie", direction)
		get_parent().linear_velocity += direction * attack.knockback
