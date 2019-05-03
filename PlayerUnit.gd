extends Unit

class_name PlayerUnit

export(int) var cost
var dest = null

func _ready():
	add_to_group(Level.PLAYER_GROUP)

func _unhandled_input(event: InputEvent) -> void:
	if _selected:
		if (event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT):
			dest = event.position
			self._selected = false
			
func selectedSetter(value):
	.selectedSetter(value)
	if _selected:
		modulate = Color(2, 2, 2, 1)
	else:
		modulate = Color(1, 1, 1, 1)