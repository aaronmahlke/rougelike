extends Node2D
@onready var player_sprite = $Sprite

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

const MAX_SPEED = 2
const ACCELLERATION = 20
const FRICTION = 10
var state = "idle"
var velocity = Vector2()

func _process(delta):
	pass

func _physics_process(delta):
	move_player(delta)
	update_anim()
	pass

func move_player(delta) -> void:
	var up = Input.is_key_pressed(KEY_W)
	var down = Input.is_key_pressed(KEY_S)
	var left = Input.is_key_pressed(KEY_A)
	var right = Input.is_key_pressed(KEY_D)

	var x_axis = -int(left) + int(right)
	var y_axis = -int(up) + int(down)

	var move_delta = Vector2(x_axis, y_axis).normalized()

	if move_delta == Vector2.ZERO:
		state = 'idle'
		if velocity.length() > (FRICTION * delta):
			velocity -= velocity.normalized() * (FRICTION * delta)
		else:
			velocity = Vector2.ZERO
	else:
		state = 'run'
		velocity += (move_delta * ACCELLERATION * delta)
		velocity = velocity.limit_length(MAX_SPEED)

	global_position += velocity
	flip_player(move_delta)

func flip_player(direction):
	if direction.x > 0:
		player_sprite.scale.x = 1
	if direction.x < 0:
		player_sprite.scale.x = -1

func update_anim():
	if player_sprite.animation != state:
		player_sprite.animation = state
	match state:
		"run":
			player_sprite.play("run")
		"idle":
			player_sprite.play("idle")
