extends PlayerUnit

class_name GroupUnit

var _target = null
var baseOffset

signal death

func _ready():
	set_as_toplevel(true)
	add_to_group(Level.GROUP_UNIT_GROUP)
	position = position.rotated(get_parent()._rotation)
	baseOffset = position
	
func clicked(mode):
	get_parent()._selected = !_selected
	
func die():
	emit_signal('death')
	.die()