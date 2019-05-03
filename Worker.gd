extends PlayerUnit

var _buildTimer = 0
var _canBuild = true
var _parentBase = null
export(float) var buildTime
export(float) var damage

signal workerDied

func _process(delta: float) -> void:
	delta *= get_node('/root/Level').gameSpeed
	
	if _canBuild:
		var buildSites = get_tree().get_nodes_in_group(Level.BUILD_SITE_GROUP)
		var closest = level.getClosest(self, buildSites)
		if closest:
			var distance = global_position.distance_to(closest.global_position)
			if distance <= attackRadius:
				_buildTimer += delta
				if _buildTimer >= buildTime and level.playerGold >= damage:
					level.playerGold -= damage
					var hitbox = DirectHitbox.new(self, closest, damage)
					level.add_child(hitbox)
					_canBuild = false
					_buildTimer = 0
			else:
				moveTowards(closest.global_position, delta)
			return

	if not is_instance_valid(_parentBase):
		die()
	if not moveTowards(_parentBase.global_position, delta):
		_canBuild = true

#hack to make workers not highlighted
func selectedSetter(value):
	_selected = value

func die():
	emit_signal('workerDied')
	.die()