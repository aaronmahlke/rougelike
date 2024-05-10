extends Node
class_name KnockbackComponent

func knockback(attack: Attack):
	var parent_pos = get_parent().global_position
	var this_position = Vector3(parent_pos.x, 0, parent_pos.z)
	var direction = (this_position - Vector3(attack.position.x, 0, attack.position.z)).normalized()

	if get_parent() is RigidBody3D:
		get_parent().linear_velocity = direction * attack.knockback
