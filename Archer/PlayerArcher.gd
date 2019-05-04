extends GroupUnit

export(float) var waitRadius
export(float) var avoidRadius
export(float) var attackRate
export(float) var hitboxSpeed
export(float) var hitboxSize
export(float) var hitboxDuration

var attackTimer = 0
export(float) var damage

func attack(target):
	attackTimer = attackRate + rand_range(-.2, .2)
	global_position += baseOffset
	var hitbox = AreaHitbox.new(self, target, Level.ENEMY_GROUP, damage, hitboxSpeed, hitboxSize, hitboxDuration, 'res://arrow.png')
	level.add_child(hitbox)
	global_position -= baseOffset

func _process(delta: float) -> void:
	global_position -= baseOffset
	delta *= get_node('/root/Level').gameSpeed
	attackTimer -= delta
	
	if is_instance_valid(_target):
		var distance = global_position.distance_to(_target.global_position)
		var closest = get_node('DetectionRange').getClosest()
		
		if distance <= attackRadius:
			if attackTimer <= 0:
				attack(_target)
		elif closest and global_position.distance_to(closest.global_position) <= attackRadius:
			if attackTimer <= 0:
				attack(closest)

		if closest:
			distance = global_position.distance_to(closest.global_position)
			if distance <= avoidRadius:
				moveTowards(2 * (global_position) + baseOffset - closest.global_position, delta)
				global_position += baseOffset
				return
		
		if distance <= waitRadius:
			pass
		else:
			moveTowards(_target.global_position, delta)
			
	else:
		moveTowards(get_parent().global_position, delta)
		
	global_position += baseOffset
	return
	var closest = get_node('DetectionRange').getClosest()
	if closest:
		var distance = global_position.distance_to(closest.global_position)
		if distance <= avoidRadius:
			moveTowards(closest.global_position, -delta)
	
	#if no target, move to base poosition
	
	return
	
	"""delta *= get_node('/root/Level').gameSpeed
	
	attackTimer -= delta
	var closest = get_node('DetectionRange').getClosest()
	if closest:
		var distance = global_position.distance_to(closest.global_position)
		if distance <= attackRadius:
			if attackTimer <= 0:
				attackTimer = attackRate
				var hitbox = AreaHitbox.new(self, closest, Level.ENEMY_GROUP, damage, hitboxSpeed, hitboxSize, hitboxDuration, 'res://arrow.png')
				level.add_child(hitbox)
			
		if distance <= avoidRadius:
			moveTowards(closest.global_position, -delta)
			return
		elif distance <= waitRadius:
			return
		else:
			moveTowards(closest.global_position, delta)
			return
	
	if dest:
		if not moveTowards(dest, delta):
			dest = null"""