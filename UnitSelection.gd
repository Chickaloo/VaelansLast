extends Node2D

var _closeTimer = -1

func _ready():
	_closeTimer = 5

func selected(unit):
	get_parent().spawn(unit)
	

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT:
		_closeTimer = 3
		
func _process(delta: float) -> void:
	_closeTimer -= delta
	if _closeTimer < 0:
		queue_free()
		get_parent()._selectionOpen = false