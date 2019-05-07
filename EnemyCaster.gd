extends "res://EnemyTank.gd"

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
				var hitbox = AreaHitbox.new(self, closest, Level.PLAYER_GROUP, damage, 20, 5, 1, 'res://arrow.png')
				level.add_child(hitbox)
	
		elif distance <= aggroRadius:
			if closest.global_position.x < self.global_position.x:
				$Sprite.scale.x = -2
			else:
				$Sprite.scale.x = 2
			moveTowards(closest.global_position, delta)
		return
		
	moveToPlayerBase(delta)
	
	