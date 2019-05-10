extends Base

class_name EnemyBase

export(int) var gold
export(Array, String, FILE, '*.tscn') var units
export(int) var numberSpawned
export(float) var spawnTime

var _spawnTimer = 0
var fps = .085

func _ready():
	spawnTime *= 1 - (float(level.levelid) / 20)
	add_to_group(Level.ENEMY_GROUP)
	add_to_group(Level.ENEMY_BASE_GROUP)

func die():
	level.playerGold += gold
	gold = 0
	.die()
	 
func _process(delta: float) -> void:
	delta *= level.gameSpeed
	
	if animationstate == 1:
		fps -= delta
		if fps < 0:
			$Sprite.frame = ($Sprite.frame + 1) % 10
			fps = .085
			if $Sprite.frame == 0:
				animationstate = 0
				
	_spawnTimer += delta
	if _spawnTimer >= spawnTime:
		_spawnTimer = 0
		animationstate = 1
		$Sprite.frame = 1
		for x in range(numberSpawned):
			var unit = units[randi() % len(units)]
			spawn(unit, Vector2(24 * randf(), 24 * randf()))
			
func spawn(unitScene, spawnOffset):
	var unit = level.spawn(unitScene)
	unit.position = self.position + spawnOffset