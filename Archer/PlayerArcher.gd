class_name PlayerArcher extends GroupUnit

export(float) var waitRadius
export(float) var avoidRadius
export(float) var attackRate
export(float) var hitboxSpeed
export(float) var hitboxSize
export(float) var hitboxDuration

var unitid = 0
var attackTimer = 0
export(float) var damage
var walkfps = .2
var sprite
var attackfps = .4

func _init():
	maxHealth *= 1 + pd.unitLevels[unitid] / 5
	damage *= 1 + pd.unitLevels[unitid] / 5
	walkSpeed *= 1 + pd.unitLevels[unitid] / 5
	sprite = get_child(0)
	basescale = 1.5
	
func attack(target):
	animationstate = 1
	attackfps = .2
	sprite.frame = 3
	attackTimer = attackRate + rand_range(-.2, .2)
	global_position += baseOffset
	var hitbox = AreaHitbox.new(self, target, Level.ENEMY_GROUP, damage, hitboxSpeed, hitboxSize, hitboxDuration, 'res://arrow.png')
	level.add_child(hitbox)
	global_position -= baseOffset

func _process(delta: float) -> void:
	global_position -= baseOffset
	delta *= get_node('/root/Level').gameSpeed
	attackTimer -= delta
	
	if animationstate == 0:
		walkfps -= delta
		if walkfps < 0:
			walkfps = .2
			sprite.frame = (sprite.frame + 1) % 3
	elif animationstate == 1:
		attackfps -= delta
		if attackfps < 0:
			attackfps = .2
			if sprite.frame < 4:
				sprite.frame += 1
			elif sprite.frame == 4:
				animationstate = 0
				sprite.frame = 0
		
	if is_instance_valid(_target):
		if _target.global_position.x < self.global_position.x:
			$Sprite.scale.x = -1.5
		else:
			$Sprite.scale.x = 1.5
		var distance = global_position.distance_to(_target.global_position)
		var closest = get_node('DetectionRange').getClosest()
		
		if distance <= attackRadius:
			if attackTimer <= 0:
				if _target.global_position.x < self.global_position.x:
					$Sprite.scale.x = -1.5
				else:
					$Sprite.scale.x = 1.5
				attack(_target)
		elif closest and global_position.distance_to(closest.global_position) <= attackRadius:
			if attackTimer <= 0:
				attack(closest)
				if closest.global_position.x < self.global_position.x:
					$Sprite.scale.x = -1.5
				else:
					$Sprite.scale.x = 1.5

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
		if get_parent().global_position.x < self.global_position.x:
			$Sprite.scale.x = -1.5
		else:
			$Sprite.scale.x = 1.5
		moveTowards(get_parent().global_position, delta)
		
	global_position += baseOffset