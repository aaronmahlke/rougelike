class_name Foliage
extends Node3D

@onready
var animations = $Animations

@onready 
var audio = $CollisionAudio

func _ready():
	pass

func _on_collision(_body:Node3D):
	animations.play("RESET")
	animations.play("collision")
	audio.play()
