extends CanvasLayer

@onready var cursor_sprite = $Sprite


func _physics_process(delta):
	var window = Vector2(get_viewport().get_window().size)
	var mouse_pos = get_viewport().get_mouse_position()
	# print(mouse_pos)
	cursor_sprite.position = mouse_pos
	pass

