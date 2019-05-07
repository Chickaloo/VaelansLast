extends Area2D

export(String, FILE, '*.tscn') var unit
export(int) var unitid
export(String) var unitName
export(String) var unitCost
var units = ["res://ArcherGroup.tscn", "res://TankGroup.tscn", "res://MageGroup.tscn"]
var _active = true

func _ready():
	unitCost = pd.unitCosts[unitid]
	
	$NameLabel.text = unitName + " Group\nCost: "
	$CostLabel.text = str(pd.unitCosts[unitid])
	$CollisionShape2D.shape.extents = $Sprite.scale * $Sprite.texture.get_size() / 2
	
	if get_node('/root/Level').playerGold < int(unitCost):
		modulate = Color(1,1,1,.2)
		$NameLabel.modulate = Color(1, 1, 1, .2)
		$CostLabel.modulate = Color(1, 1, 1, .2)
		_active = false
		
	connect('input_event', self, 'clicked')
	
func clicked( viewport, event, shape_idx ):
	if (event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT):
		if _active:
			get_parent().selected(units[unitid], unitid)
			get_parent()._closeTimer = -1
		
func _process(delta: float) -> void:
	if get_node('/root/Level').playerGold < int(unitCost):
		modulate = Color(1,1,1,.2)
		$NameLabel.modulate = Color(1, 1, 1, .2)
		$CostLabel.modulate = Color(1, 1, 1, .2)
		_active = false
	else:
		modulate = Color(1,1,1)
		$NameLabel.modulate = Color(1, 1, 1)
		$CostLabel.modulate = Color(1, 1, 1)
		_active = true