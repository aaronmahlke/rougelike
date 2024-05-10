extends Area3D
class_name HitboxComponent

@export
var health_component : HealthComponent

@export
var knockback_component : KnockbackComponent

signal damage_taken

func damage(attack: Attack):
	damage_taken.emit()
	
	if health_component:
		health_component.damage(attack)
	else:
		print("No health component found")
		
	if knockback_component:
		knockback_component.knockback(attack)
	else:
		print("No knockback component found")
		
