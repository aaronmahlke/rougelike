extends Area3D
class_name AttackBox

@export
var DAMAGE: float = 10

@export
var KNOCKBACK: float = 10

func _on_area_entered(area:Area3D):
	print("area entered")
	print(area.name)
	if area is HitboxComponent:
		print("area is hitbox component")
		var attack = Attack.new()
		attack.damage = DAMAGE
		attack.knockback = KNOCKBACK
		area.damage(attack)

