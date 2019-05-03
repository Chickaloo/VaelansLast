extends Base

class_name EnemyBase

export(int) var gold
export(Array, String, FILE, '*.tscn') var units

var TEMP_TIMER = 0

func _ready():
	add_to_group(Level.ENEMY_GROUP)
	add_to_group(Level.ENEMY_BASE_GROUP)

func die():
	level.playerGold += gold
	gold = 0
	.die()
	 
func _process(delta: float) -> void:
	delta *= level.gameSpeed
	TEMP_TIMER += delta
	if TEMP_TIMER >= 3:
		TEMP_TIMER = 0
		var unit = units[randi() % len(units)]
		spawn(unit)
		
		