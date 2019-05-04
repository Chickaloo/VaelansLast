extends Area2D

class_name BuildSiteMarker

func _ready():
	$Shape.shape.extents = $Sprite.scale * $Sprite.get_texture().get_size() / 2
	
func _process(delta: float) -> void:
	if get_node('/root/Level/Canvas/ClickOptions').mode != ClickOptions.BUILDING:
		queue_free()
	position = get_global_mouse_position()