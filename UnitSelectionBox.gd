extends Area2D

export(String, FILE, '*.tscn') var unit
export(String) var unitName
export(String) var unitCost

var _active = true

func _ready():
	$NameLabel.text = unitName
	$CostLabel.text = unitCost
	$CollisionShape2D.shape.extents = $Sprite.scale * $Sprite.texture.get_size() / 2
	
	connect('input_event', self, 'clicked')
	
func clicked( viewport, event, shape_idx ):
	if (event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT):
		if _active:
			get_parent().selected(unit)
		
func _process(delta: float) -> void:
	if get_node('/root/Level').playerGold < int(unitCost):
		modulate = Color(1,1,1,.5)
		_active = false
	else:
		modulate = Color(1,1,1,1)
		_active = true