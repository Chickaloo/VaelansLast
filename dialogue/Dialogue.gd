class_name Dialogue extends Control

var portrait
var portrait_text
var body_text

var dialogue
var isEnd = false

func _ready():
	self.pause_mode = Node.PAUSE_MODE_PROCESS
	portrait_text = get_child(0).get_child(0)
	body_text = get_child(0).get_child(1)
	portrait = get_child(1)	
	
	portrait_text.text = dialogue.portrait_text
	body_text.text = dialogue.body_text
	portrait.texture = dialogue.portrait
	get_tree().paused = true

func _unhandled_input(event):
	if (event is InputEventKey and event.pressed) or (event is InputEventMouseButton and event.is_pressed()):
		print("input captured by control")
		next()
		
func next():
	if dialogue.step():
		portrait_text.text = dialogue.portrait_text
		body_text.text = dialogue.body_text
		portrait.texture = dialogue.portrait
	else:
		get_tree().paused = false
		queue_free()
		if isEnd:
			get_tree().change_scene("res://LevelSelect.tscn")