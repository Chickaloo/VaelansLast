extends Actor

func _ready():
	add_to_group(Level.BUILD_SITE_GROUP)

func die():
	var base = level.spawn('res://BasicPlayerBase.tscn')
	base.position = position
	.die()