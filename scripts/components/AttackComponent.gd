extends Area3D
class_name AttackComponent

@export
var DAMAGE: float = 10

@export
var KNOCKBACK: float = 10

func _on_area_entered(area:Area3D):
	if area is HitboxComponent:
		var attack = Attack.new()
		attack.damage = DAMAGE
		attack.knockback = KNOCKBACK
		attack.position = owner.global_position
		area.damage(attack)
