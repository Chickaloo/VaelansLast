extends HBoxContainer

class_name ClickOptions

var mode = 0

const SELECTION = 0
const PAUSED = 1
const BUILDING = 2
const FIREBALL = 3

func _ready():
	get_child(mode).modulate = Color(.5, .5, .5)
	for child in get_children():
		child.connect('pressed', self, 'pressed', [child])
		
func pressed(button):
	get_child(mode).modulate = Color(1,1,1)
	
	if mode == PAUSED:
		mode = SELECTION
		get_child(PAUSED).text = 'Pause'
	else:
		mode = button.get_index()
	
	get_child(mode).modulate = Color(.5,.5,.5)
	
	if mode == PAUSED:
		get_tree().paused = true
		get_child(PAUSED).text = 'Unpause'
	
	if mode == BUILDING:
		get_node('/root/Level').spawn('res://BuildSiteMarker.tscn')
	
	get_tree().set_input_as_handled()