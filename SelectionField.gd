extends Area2D

class_name SelectionField

var corner

func _ready() -> void:
	var collision = CollisionShape2D.new()
	collision.shape = RectangleShape2D.new()
	collision.name = 'Collision'
	add_child(collision)
	corner = get_global_mouse_position()
	monitorable = false
	z_index = 20
	
	var sprite = Globals.newSprite(0, 0, 'res://SelectionBox.png')
	sprite.name = 'Sprite'
	sprite.modulate = Color(1,1,1,.3)
	add_child(sprite)

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouse:
		if event.button_mask & BUTTON_LEFT == BUTTON_LEFT:
			var middle = (get_global_mouse_position() - corner) / 2
			$Collision.shape.extents = middle.abs()
			global_position = middle + corner
			$Sprite.scale = Globals.calcSpriteScale($Sprite, abs(middle.y * 2), abs(middle.x * 2))
		else:
			for area in get_overlapping_areas():
				#I have to directly use the srting to prevent circular dependancies with Level
				if 'groupUnit' in area.get_groups():
					area.get_parent().clicked()
			queue_free()