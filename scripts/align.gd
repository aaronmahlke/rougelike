class_name Align
extends Node

# Called when the node enters the scene tree for the first time.
func _ready():
	var parent = get_parent()
	parent.rotate_x(deg_to_rad(-20))
