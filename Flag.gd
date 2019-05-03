class_name Flag extends Area2D

export(String, FILE, '*.tscn') var level

export(float) var frameTime
export(int) var levelid 
export(int) var panelposition
var _timer = 0
var levelhover = preload("res://LevelHoverPanel.tscn")
var panel
var panelpositions = [300, 500]

func _ready():
	connect('input_event', self, 'clicked')
	
func clicked( viewport, event, shape_idx ):
	if (event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT):
		get_tree().change_scene(level)
		
func _mouse_enter():
		hover()

func _mouse_exit():
	unhover()

func _process(delta):
	_timer += delta
	if _timer >= frameTime:
		_timer = 0
		$Sprite.frame = ($Sprite.frame + 1) % 4

func hover():
	
	panel = levelhover.instance()
	panel.global_position = Vector2(panelpositions[levelid], 200)
	panel.scale = Vector2(2,2)
	add_child(panel)
	panel.set_level(levelid)
	
	"""text = Label.new()
	get_parent().add_child(text)
	text.set_text("Row: " + str(global_position.x) + "\nCol: " + str(global_position.y))
	text.rect_position = Vector2(800, 20)"""
	
	$Sprite.modulate = Color(1.3, 1.3, 1.3, 1)
	#hovering = true
	
func unhover():
	panel.queue_free()
	#text.queue_free()
	
	$Sprite.modulate = Color(1, 1, 1, 1)
	#hovering = false