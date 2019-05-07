extends Unit

class_name EnemyUnit

export(int) var gold

func _ready():
	add_to_group(Level.ENEMY_GROUP)
	add_to_group(Level.ENEMY_UNIT_GROUP)

func die():
	level.playerGold += gold
	
	var st = ScoreText.new(gold)
	st.rect_global_position = self.global_position
	get_parent().add_child(st)
	
	.die()
	


class ScoreText extends Label:
	
	var speed = 100
	var decel = 100
	var lifetime = speed/decel
	var direction = Vector2(0, -1)
	
	func _init(score):
		set_text("+" + str(score) + "g")
		modulate = Color(1, 1, 0)
		
	func _process(delta):
		if speed > 0:
			speed -= (decel*delta)
		lifetime -= delta
		
		self.rect_position = self.rect_position + direction * speed * delta
		
		if lifetime < 0:
			queue_free()
			set_process(false)
		