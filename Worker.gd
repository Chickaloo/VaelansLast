extends PlayerUnit

var _buildTimer = 0
var _canBuild = true
var _parentBase = null

var walkfps = .2

export(float) var buildTime
export(float) var damage

signal workerDied

func _process(delta: float) -> void:
	delta *= get_node('/root/Level').gameSpeed
	walkfps -= delta
	
	if walkfps < 0:
		walkfps = .2
		$Sprite.frame = ($Sprite.frame + 1) % 7
	
	if _canBuild:
		var buildSites = get_tree().get_nodes_in_group(Level.BUILD_SITE_GROUP)
		var closest = level.getClosest(self, buildSites)
		if closest:
			var distance = global_position.distance_to(closest.global_position)
			if distance <= attackRadius:
				_buildTimer += delta
				if _buildTimer >= buildTime:
					#level.playerGold -= damage
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

func die():
	emit_signal('workerDied')
	.die()