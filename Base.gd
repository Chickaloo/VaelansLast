extends Actor

class_name Base

export(Vector2) var spawnOffset

func _ready():
	pass
	
func selectSpawn():
	pass
	
func die():
	level.baseDestroyed(self)
	.die()
	
func spawn(unitScene):
	var unit = level.spawn(unitScene)
	unit.position = self.position + spawnOffset