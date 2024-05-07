extends Node3D

@onready
var animations = $Animations

@onready 
var audio	= $Audio

func _ready():
	pass

func _on_collision(body:Node3D):
	print(body.name)
	animations.play("RESET")
	animations.play("collision")
	audio.play()
