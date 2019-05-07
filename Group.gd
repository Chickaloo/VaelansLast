extends PlayerUnit

#attack and aggro radius do nothing.  Always approaches if detected

export(float) var waitRadius
export(float) var avoidRadius
export(String, FILE, '*.tscn') var baseUnit
export(Array, int) var upgradeCosts
var unit = [preload("res://Archer/PlayerArcher.tscn"), preload("res://Tank/PlayerTank.tscn"), preload("res://Mage.tscn")]

var _level = 0
var _rotation
var _units = []
var detectionRange
export(int) var unitid

func unitDied(unit):
	_units.erase(unit)
	if len(_units) == 0:
		queue_free()

func _init():
	_rotation = rand_range(-3.14, 3.14)
	detectionRange = get_child(2)
	
func _ready():
	baseUnit = baseUnit.substr(0, len(baseUnit) - 5)
	
	for i in range(pd.unitSizes[unitid]):
		var T = unit[unitid].instance()
		_units.append(T)
		add_child(T)
		T.baseOffset = Vector2(rand_range(-10, 10), rand_range(-10, 10))
		T.global_position = self.global_position + T.baseOffset
		T.connect('death', self, 'unitDied', [T])

func _process(delta: float) -> void:
	delta *= get_node('/root/Level').gameSpeed
	
	var closest = get_node('DetectionRange').getClosest()
	if closest:
		var distance = global_position.distance_to(closest.global_position)
		
		for unit in _units:
			var wr = weakref(closest).get_ref();
			
			if wr:
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
		unit.position = position

func clicked():
	for unit in _units:
		unit._selected = true
	#upgrade()

func upgrade():
	if _level < len(upgradeCosts):
		if level.playerGold >= upgradeCosts[_level]:
			level.playerGold -= upgradeCosts[_level]
			var st = SpendText.new(upgradeCosts[_level])
			st.rect_global_position = self.global_position
			get_parent().add_child(st)
			
			_level += 1
			var tempUnits = []
			for unit in _units:
				var scene = load(baseUnit + 'V' + str(_level + 1) + '.tscn')
				var node = scene.instance()
				add_child(node)
				node.global_position = unit.global_position
				node.baseOffset = unit.baseOffset
				unit.queue_free()
				tempUnits.append(node)
			_units.clear()
			_units = tempUnits

func die():
	print('group died lol')
	.die()