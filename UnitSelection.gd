extends Node2D

func _ready():
	pass

func selected(unit):
	get_parent().spawn(unit)
	
func _process(delta: float) -> void:
	if get_node('/root/Level/Camera/ClickOptions').mode != ClickOptions.SPAWNING:
		queue_free()