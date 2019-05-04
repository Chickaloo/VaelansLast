extends PlayerUnit

class_name GroupUnit

var _target = null
var baseOffset

signal death

var _selected = false setget selectedSetter

var mouse_over = false
 
func _mouse_over(over):
	self.mouse_over = over

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT:
		if mouse_over:
			get_parent().clicked()
			get_tree().set_input_as_handled()
		elif _selected:
			get_parent().dest = get_global_mouse_position()
			self._selected = false
			
func selectedSetter(value):
	_selected = value
	if _selected:
		modulate = Color(2, 2, 2, 1)
	else:
		modulate = Color(1, 1, 1, 1)

func _ready():
	set_as_toplevel(true)
	add_to_group(Level.GROUP_UNIT_GROUP)
	position = position.rotated(get_parent()._rotation)
	baseOffset = position
	connect("mouse_entered",self,"_mouse_over", [true])
	connect("mouse_exited",self,"_mouse_over", [false])
	
func die():
	emit_signal('death')
	.die()