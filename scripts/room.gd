extends Node3D
class_name Room

@export var n: MeshInstance3D
@export var e: MeshInstance3D
@export var s: MeshInstance3D
@export var w: MeshInstance3D

var grid_position = Vector2(0,0)

@onready
var actual_doors = {
	Vector2(-1,0): n,
	Vector2(1,0): s,
	Vector2(0,-1): e,
	Vector2(0,1): w,
}

var doors = {
	Vector2(-1,0): false,
	Vector2(1,0): false,
	Vector2(0,-1): false,
	Vector2(0,1): false,
}

func make_room(grid_pos, mandatory_doors := {
	Vector2(-1,0): false,
	Vector2(1,0): false,
	Vector2(0,-1): false,
	Vector2(0,1): false,
}):
	grid_position = grid_pos
	for door in mandatory_doors:
		if mandatory_doors[door] == false:
			var chance = randi_range(0,100)
			if chance < 25:
				mandatory_doors[door] = true
	doors = mandatory_doors
	print("doors: ", doors)
	

func draw_doors():
	for direction in doors:
		if doors[direction]:
			actual_doors[direction].visible = true
			global_position = 2 * Vector3(grid_position.x, 0, grid_position.y)
			
	
