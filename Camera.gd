extends Camera2D

var CurrentMouseCoords
var LastMouseCoords

func _ready():
	LastMouseCoords = get_global_mouse_position()
		
func _process(delta: float) -> void:
	CurrentMouseCoords = get_global_mouse_position()
	if Input.is_mouse_button_pressed(BUTTON_RIGHT):
		var diff = LastMouseCoords - CurrentMouseCoords
		translate(diff * 5)
	LastMouseCoords = CurrentMouseCoords
	
func moveTo(pos):
	var difference = pos - global_position
	translate(difference)