extends CharacterBody2D
@onready var player_sprite = $Sprite
@onready var bullet = preload("res://components/Bullet.tscn")
@onready var holdable = $Holdable
@onready var sound_player = $Holdable/HoldableSound

const MAX_SPEED = 20
const MAX_SPRINT_SPEED = 40
const ACCELLERATION = 400
const FRICTION = 200
const SHOOT_COOLDOWN = 0.1

var bullet_offset = 30
var current_shoot_cooldown = 0.0
var last_direction = Vector2.ZERO
var state = "idle"
var character_direction = Vector2.ZERO

var idle_frames = {
	'idle': 0,
	'n': 2,
	'ne': 1,
	'e': 0,
	'se': 7,
	's': 6,
	'sw': 5,
	'w': 4,
	'nw': 3
}




func _physics_process(delta):
	move_player(delta)
	rotate_holdable()
	shoot_projectile()
	update_anim()
	pass

func move_player(delta) -> void:
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var is_sprinting = Input.is_action_pressed("sprint")
	var move_delta = direction.normalized()
	character_direction = move_delta

	if move_delta == Vector2.ZERO:
		state = 'idle'
		if velocity.length() > (FRICTION * delta):
			velocity -= velocity.normalized() * (FRICTION * delta)
		else:
			velocity = Vector2.ZERO
	else:
		last_direction = move_delta
		if is_sprinting:
			state = 'sprint-' + get_quarter(character_direction)
			velocity += (move_delta * ACCELLERATION * delta)
			velocity = velocity.limit_length(MAX_SPRINT_SPEED)
		else:
			state = 'walk-' + get_quarter(character_direction)
			velocity += (move_delta * ACCELLERATION * delta)
			velocity = velocity.limit_length(MAX_SPEED)

	move_and_slide()

func get_quarter(dir) -> String:
	if dir.x < 0:
		if dir.y < 0:
			return 'nw'
		elif dir.y > 0:
			return 'sw'
		else:
			return 'w'
	if dir.x > 0:
		if dir.y < 0:
			return 'ne'
		elif dir.y > 0:
			return 'se'
		else:
			return 'e'
	if dir.y < 0:
		return 'n'
	if dir.y > 0:
		return 's'
	return 'idle'

	
func update_anim():
	if state == 'idle':
		player_sprite.animation = 'idle'
		player_sprite.stop()
		player_sprite.frame = idle_frames[get_quarter(last_direction)]
	else:
		if player_sprite.animation != state:
			player_sprite.animation = state
			player_sprite.play()


func rotate_holdable():
	var mouse_pos = get_global_mouse_position()
	var direction = (mouse_pos - global_position).normalized()
	var angle = direction.angle()
	holdable.rotation = angle
	
func shoot_projectile():
	if current_shoot_cooldown >= 0:
		current_shoot_cooldown -= get_process_delta_time()

	if Input.is_action_pressed("shoot"):
		if current_shoot_cooldown <= 0:
			spawn_bullet()
			current_shoot_cooldown = SHOOT_COOLDOWN

func spawn_bullet():
	var bullet_instance = bullet.instantiate()
	get_parent().add_child(bullet_instance)
	var delta = (get_global_mouse_position() - global_position).normalized() * 1000
	var offset = delta.normalized() * bullet_offset
	bullet_instance.global_position = global_position + offset
	bullet_instance.velocity = delta
	bullet_instance.rotation = holdable.rotation

	sound_player.play()


