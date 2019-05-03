extends Area2D

class_name BuildSiteMarker

func _ready():
	$Shape.shape.extents = $Sprite.scale * $Sprite.get_texture().get_size() / 2
	
func _process(delta: float) -> void:
	if get_node('/root/Level/Camera/ClickOptions').mode != 3:
		queue_free()
	position = get_viewport().get_mouse_position()