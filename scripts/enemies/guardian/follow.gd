extends EnemyState

@export
var hitbox_component : HitboxComponent


func enter(_msg := {}):
	if enemy.sprite != null:
		enemy.sprite.play("idle")
	if hitbox_component:
		hitbox_component.damage_taken.connect(stun)
	
func update(delta) -> void:
	var direction = (Global.player.global_position - enemy.global_position).normalized()
	enemy.linear_velocity += (direction * enemy.ACCELLERATION * delta)
	enemy.linear_velocity += enemy.linear_velocity * -1 * enemy.FRICTION
	enemy.linear_velocity = enemy.linear_velocity.limit_length(enemy.MAX_SPEED)
	
	# transition
	
func stun():
	print("start stun")
	state_machine.transition_to("Stun")
