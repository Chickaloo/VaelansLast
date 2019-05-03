extends GroupUnit

export(float) var attackRate
var attackTimer = 0
export(float) var damage

func _process(delta: float) -> void:
	global_position -= baseOffset
	delta *= get_node('/root/Level').gameSpeed
	attackTimer -= delta
	
	if is_instance_valid(_target):
		var distance = global_position.distance_to(_target.global_position)
		var closest = get_node('DetectionRange').getClosest()
		
		if distance <= attackRadius:
			if attackTimer <= 0:
				attackTimer = attackRate + rand_range(-.2, .2)
				var hitbox = DirectHitbox.new(self, _target, damage)
				level.add_child(hitbox)
		elif closest and global_position.distance_to(closest.global_position) <= attackRadius:
			if attackTimer <= 0:
				attackTimer = attackRate + rand_range(-.2, .2)
				var hitbox = DirectHitbox.new(self, closest, damage)
				level.add_child(hitbox)
		else:
			moveTowards(_target.global_position, delta)
	else:
		moveTowards(get_parent().global_position, delta)
		
	global_position += baseOffset
	
	return
	
	
	delta *= get_node('/root/Level').gameSpeed
	
	attackTimer -= delta
	var closest = get_node('DetectionRange').getClosest()
	if closest:
		var distance = global_position.distance_to(closest.global_position)
		if distance <= attackRadius:
			if attackTimer <= 0:
				attackTimer = attackRate
				var hitbox = DirectHitbox.new(self, closest, damage)
				level.add_child(hitbox)
			return
		elif distance <= aggroRadius:
			moveTowards(closest.global_position, delta)
			return
	
	if dest:
		if not moveTowards(dest, delta):
			dest = null