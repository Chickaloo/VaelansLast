extends Unit

class_name PlayerUnit

export(int) var cost
var dest = null

func _ready():
	add_to_group(Level.PLAYER_GROUP)