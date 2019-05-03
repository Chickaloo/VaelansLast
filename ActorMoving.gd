extends Actor

class_name ActorMoving

export(float) var walkSpeed

func _ready() -> void:
	pass # Replace with function body.

func moveTowards(destination, delta):
	var velocity = level.navigate(self, destination, walkSpeed * delta)
	translate(velocity)
	return velocity != Vector2(0,0)
		
func moveToPlayerBase(delta):
	var distances = []
	for node in get_tree().get_nodes_in_group(Level.PLAYER_BASE_GROUP):
		distances.append(global_position.distance_to(node.global_position))
	if len(distances) > 0:
		var closest = get_tree().get_nodes_in_group(Level.PLAYER_BASE_GROUP)[Globals.minIndex(distances)]
		return moveTowards(closest.global_position, delta)
	return false

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
