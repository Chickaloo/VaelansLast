extends HBoxContainer

class_name ClickOptions

var mode = 0

const SELECTION = 0
const SPAWNING = 1
const PAUSED = 2
const BUILDING = 3

func _ready():
	get_child(mode).modulate = Color(.5, .5, .5)
	for child in get_children():
		child.connect('pressed', self, 'pressed', [child])
		
func pressed(button):
	if get_tree().paused:
		if button.get_index() == PAUSED:
			get_child(PAUSED).modulate = Color(1,1,1)
			mode = SELECTION
			get_child(SELECTION).modulate = Color(.5,.5,.5)
			get_tree().paused = false
	elif button.get_index() != mode:
		get_child(mode).modulate = Color(1,1,1)
		mode = button.get_index()
		get_child(mode).modulate = Color(.5,.5,.5)
		
		if mode == PAUSED:
			get_tree().paused = true
		elif mode == SPAWNING:
			get_tree().call_group(Level.PLAYER_BASE_GROUP, 'startSpawnSelection')
		elif mode == BUILDING:
			get_node('/root/Level').spawn('res://BuildSiteMarker.tscn')
	
	
	
	get_tree().set_input_as_handled()