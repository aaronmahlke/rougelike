extends Area2D

@export var speed: float = 200
@export var velocity: Vector2 = Vector2.ZERO


@onready var sprite = $Sprite

func _ready():
	pass


func _physics_process(delta):
	position += velocity.normalized() * speed * delta
	# rotation = velocity.angle()


func cull():
	if position.x < -100 or position.x > get_viewport_rect().size.x + 100 or position.y < -100 or position.y > get_viewport_rect().size.y + 100:
		queue_free()

