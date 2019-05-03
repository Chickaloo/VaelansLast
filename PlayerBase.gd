extends Base

class_name PlayerBase

var _workerActive = false
var _workerSpawnTimer

export(float) var workerSpawnTime
export(String, FILE, '*.tscn') var unitSelector

func _ready():
	_workerSpawnTimer = workerSpawnTime
	var x = Level
	add_to_group(Level.PLAYER_GROUP)
	add_to_group(Level.PLAYER_BASE_GROUP)

#opens up selection of availible units based on unit list
func startSpawnSelection():
	var scene = load(unitSelector)
	var node = scene.instance()
	add_child(node)
	
func spawn(unitScene):
	var unit = level.spawn(unitScene)
	if level.playerGold >= unit.cost:
		level.playerGold -= unit.cost
		var st = SpendText.new(unit.cost)
		st.rect_global_position = self.global_position
		get_parent().add_child(st)
		unit.setInitialPosition(self.position + Vector2(24 * randf(), 24 * randf()))
	else:
		unit.free()
		
func _process(delta: float) -> void:
	if not _workerActive:
		var buildSites = get_tree().get_nodes_in_group(Level.BUILD_SITE_GROUP)
		if len(buildSites) > 0:
			_workerSpawnTimer += delta
			if _workerSpawnTimer >= workerSpawnTime:
				_workerSpawnTimer = 0
				var worker = level.spawn('res://Worker.tscn')
				worker.position = position
				worker.connect('workerDied', self, 'workerDead')
				worker._parentBase = self
				_workerActive = true

func workerDead():
	_workerActive = false