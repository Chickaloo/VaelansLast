tool
extends TileMap

class_name TileGrid

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if not Engine.is_editor_hint():
		#var i = 0
		var A = get_tree().get_root().get_node('Level').A
		for pos in get_used_cells():
			if get_cell(pos.x, pos.y) == 1:
				var npos = (map_to_world(pos) + cell_size / 2) * scale
				#A.add_point(i, Vector3(pos.x, pos.y, 0))
				A.add_point(32*pos.y + pos.x, Vector3(npos.x, npos.y, 0))
				#A.connect_points(i, i - 21)
				#A.connect_points(i, i - 1)
			#i += 1
		
		for pos in get_used_cells():
			if get_cell(pos.x, pos.y) == 1:
				#A.add_point(i, Vector3(pos.x, pos.y, 0))
				if get_cell(pos.x+1, pos.y) ==1:
					A.connect_points(32*pos.y + pos.x, 32*pos.y + pos.x + 1)
				if get_cell(pos.x-1, pos.y) ==1:
					A.connect_points(32*pos.y + pos.x, 32*pos.y + pos.x - 1)
				if get_cell(pos.x, pos.y+1) ==1:
					A.connect_points(32*(pos.y+1) + pos.x, 32*pos.y + pos.x)
				if get_cell(pos.x, pos.y-1) ==1:
					A.connect_points(32*(pos.y-1) + pos.x, 32*pos.y + pos.x)
	
	return
	if Engine.is_editor_hint():
		var x = TileGridUpdater.new()
		add_child(x)
		
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
#	pass
