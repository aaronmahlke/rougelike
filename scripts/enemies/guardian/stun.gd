extends EnemyState

@export
var STUN_TIME = 1.0
var timer: float = 0

func enter(_msg := {}):
	timer = STUN_TIME
	enemy.linear_velocity = Vector3.ZERO
	enemy.sprite.play("hurt")
	print("stun")
	
func update(delta):
	timer -= delta
	if timer <= 0:
		print('stun end')
		state_machine.transition_to("Follow")
	
