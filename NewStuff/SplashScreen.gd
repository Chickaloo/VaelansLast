extends Control

var label
var label_text = "[Press Any Button]"
var label_timer = -3.5
var label_cycle = .75
var label_start_pos = Vector2(0,0)
var label_pos_cycle = 0
var anim_time = 3

var background
var background_cycle = 0


func _ready():
	label = get_child(0)
	label.text = ""
	label_start_pos = label.rect_position
	
	background = get_child(1)

func _process(delta):
	if background_cycle < 3.1415:
		background_cycle += delta
		background.position.y = 1000 - 1000*sin(background_cycle/2)*sin(background_cycle/2)*sin(background_cycle/2)
	else:
		background.position.y += 5*delta
	label_timer += delta
	label_pos_cycle += delta
	anim_time -= delta
	
	if label_timer < 0:
		label.text = ""
	else:
		label.text = label_text
		
	if label_timer > label_cycle:
		label_timer = -.25
		
	label.rect_position = label_start_pos + Vector2(0, cos(label_pos_cycle) * 10)
	
	if anim_time < -10:
		transition_to_menu()

func _unhandled_input(event):
	if anim_time < 10:
		if event.pressed:
			transition_to_menu()
			
func transition_to_menu():
	get_tree().change_scene("res://scenes/LevelSelect.tscn")