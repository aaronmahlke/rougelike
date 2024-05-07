extends Node3D

@onready
var animations = $Animations

func _ready():
	pass

func _on_collision(body:Node3D):
	print(body.name)
	animations.play("collision")
