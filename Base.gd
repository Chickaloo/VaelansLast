extends Actor

class_name Base

func _ready():
	pass
	
func selectSpawn():
	pass
	
func die():
	level.baseDestroyed(self)
	.die()