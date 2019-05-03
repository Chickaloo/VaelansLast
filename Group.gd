extends PlayerUnit

#attack and aggro radius do nothing.  Always approaches if detected

export(float) var waitRadius
export(float) var avoidRadius

var _rotation
var _units = []

func unitDied(unit):
	_units.erase(unit)
	if len(_units) == 0:
		queue_free()

func _init():
	_rotation = rand_range(-3.14, 3.14)

func _ready():
	for child in get_children():
		if Level.GROUP_UNIT_GROUP in child.get_groups():
			_units.append(child)
			child.connect('death', self, 'unitDied', [child])

func _process(delta: float) -> void:
	delta *= get_node('/root/Level').gameSpeed
	
	var closest = get_node('DetectionRange').getClosest()
	if closest:
		var distance = global_position.distance_to(closest.global_position)
		
		for unit in _units:
			unit._target = closest
		
		if distance <= avoidRadius:
			moveTowards(closest.global_position, -delta)
			return
		elif distance <= waitRadius:
			return
		else:
			moveTowards(closest.global_position, delta)
			return
	
	if dest:
		if not moveTowards(dest, delta):
			dest = null
			
func setInitialPosition(position):
	self.position = position
	for unit in _units:
		unit.translate(position)
		
func selectedSetter(value):
	for unit in _units:
		unit._selected = value
	_selected = value
			
func die():
	print('group died lol')
	.die()