extends EnemyUnit

export(float) var attackRate
var attackTimer = 0
export(float) var damage

func _ready():
	maxHealth *= 1 + level.levelid / 10
	walkSpeed *= 1 + level.levelid / 10
	damage *= 1 + level.levelid / 10
	_health = maxHealth
	$Sprite.modulate = Color((1 - float(level.levelid) / 10), 0, 0, 1)

func _process(delta: float) -> void:
	delta *= level.gameSpeed
	attackTimer -= delta
	var closest = get_node('DetectionRange').getClosest()
	if closest:
		if closest.global_position.x < self.global_position.x:
			$Sprite.scale.x = -2
		else:
			$Sprite.scale.x = 2
		var distance = global_position.distance_to(closest.global_position)
		if distance <= attackRadius:
			if attackTimer <= 0:
				attackTimer = attackRate
				var hitbox = DirectHitbox.new(self, closest, damage)
				level.add_child(hitbox)
		elif distance <= aggroRadius:
			if closest.global_position.x < self.global_position.x:
				$Sprite.scale.x = -2
			else:
				$Sprite.scale.x = 2
			moveTowards(closest.global_position, delta)
		return
		
	moveToPlayerBase(delta)
	
	