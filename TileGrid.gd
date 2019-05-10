tool
extends TileMap

class_name TileGrid

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if not Engine.is_editor_hint():
		var i = 0
		var A = get_tree().get_root().get_node('Level').A
		for pos in get_used_cells():
			if get_cell(pos.x, pos.y) == 1:
				var npos = (map_to_world(pos) + cell_size / 2) * scale
				npos += position
				#A.add_point(i, Vector3(pos.x, pos.y, 0))
				A.add_point(i, Vector3(npos.x, npos.y, 0))
				#A.connect_points(i, i - 21)
				#A.connect_points(i, i - 1)
			i += 1
		
		i = 0
		for pos in get_used_cells():
			if get_cell(pos.x, pos.y) == 1:
				var npos = (map_to_world(pos) + cell_size / 2) * scale
				npos += position
				if get_cell(pos.x+1, pos.y) ==1:
					var id = A.get_closest_point(Vector3(npos.x + cell_size.x * scale.x, npos.y, 0))
					A.connect_points(id, i)
				if get_cell(pos.x-1, pos.y) ==1:
					var id = A.get_closest_point(Vector3(npos.x - cell_size.x * scale.x, npos.y, 0))
					A.connect_points(id, i)
				if get_cell(pos.x, pos.y+1) ==1:
					var id = A.get_closest_point(Vector3(npos.x, npos.y + cell_size.y * scale.y, 0))
					A.connect_points(id, i)
				if get_cell(pos.x, pos.y-1) ==1:
					var id = A.get_closest_point(Vector3(npos.x, npos.y - cell_size.y * scale.y, 0))
					A.connect_points(id, i)
			i += 1
	
	return
	if Engine.is_editor_hint():
		var x = TileGridUpdater.new()
		add_child(x)
		
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
#	pass
