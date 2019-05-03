extends EnemyUnit

export(float) var attackRate
var attackTimer = 0
export(float) var damage

func _ready():
	pass

func _process(delta: float) -> void:
	delta *= level.gameSpeed
	attackTimer -= delta
	var closest = get_node('DetectionRange').getClosest()
	if closest:
		var distance = global_position.distance_to(closest.global_position)
		if distance <= attackRadius:
			if attackTimer <= 0:
				attackTimer = attackRate
				var hitbox = DirectHitbox.new(self, closest, damage)
				level.add_child(hitbox)
		elif distance <= aggroRadius:
			moveTowards(closest.global_position, delta)
		return
		
	moveToPlayerBase(delta)
	
	