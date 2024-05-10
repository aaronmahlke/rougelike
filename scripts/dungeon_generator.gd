extends Node
var map: Array[Vector2]

var room_scene = load("res://scenes/room.tscn")

func _ready():
	start_generation()

func _process(delta):
	if Input.is_action_just_pressed("dash"):
		print("test")
		start_generation()

	
func start_generation():
	map = [Vector2(0,0)]
	var parent = get_children()
	for child in parent:
		if child is Room:
			child.queue_free()
	
	var new_doors = {
		Vector2(-1,0): false,
		Vector2(1,0): true,
		Vector2(0,-1): false,
		Vector2(0,1): false,
	}
	var room = generate_room(Vector2(0,0), new_doors)
	walk_rooms(room)
	print(map)

func walk_rooms(room:Room):
	for direction in room.doors:
		print(room.doors[direction])
		if room.doors[direction]:
			var grid_pos = room.grid_position + direction
			if grid_pos in map:
				continue
			map.append(grid_pos)
			var new_doors = {
				Vector2(-1,0): false,
				Vector2(1,0): false,
				Vector2(0,-1): false,
				Vector2(0,1): false,
			}
			new_doors[-direction] = true
			#generate_room(grid_pos, new_doors)
			walk_rooms(generate_room(grid_pos, new_doors))
	
func generate_room(grid_pos, doors):
	var instance = room_scene.instantiate()
	var room = Room.new()
	room.make_room(grid_pos, doors)
	instance.doors = room.doors
	instance.grid_position = room.grid_position
	add_child(instance)
	instance.draw_doors()
	return room
	
