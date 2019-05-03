tool
extends Node

# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"

const SPRITES = {}

class_name TileGridUpdater

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var p = get_parent()
	for tile in p.get_used_cells():
		var up = tile + Vector2(0,-1)
		if p.get_cellv(up) == 0 and p.get_cellv(tile) == 0:
			p.set_cellv(tile, 2)
		elif p.get_cellv(tile) == 2 and p.get_cellv(up) == 1:
			p.set_cellv(tile, 0)
#	pass
