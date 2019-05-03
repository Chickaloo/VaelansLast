extends ActorMoving

class_name Unit

export(float) var attackRadius
export(float) var aggroRadius

func _ready() -> void:
	pass # Replace with function body.

func setInitialPosition(pos):
	position = pos

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
