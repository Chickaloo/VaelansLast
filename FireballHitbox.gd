extends AreaHitbox

class_name FireballHitbox

var animTimer = 0

func _init(source, target, damage).(source, target, 'enemy', damage, 50, 10, 1, 'res://assets/images/effects/fireballanim.png'):
	$Sprite.hframes = 4
	$Sprite.scale.x *= 4

func _ready():
	pass

func _process(delta: float) -> void:
	animTimer += delta
	if animTimer >= .1:
		animTimer = 0
		$Sprite.frame = ($Sprite.frame + 1) % 4
		
func hit(area):
	if searchGroup in area.get_groups():
		area.getHit(self)
		call_deferred("queue_free")
		var explosion = AreaHitbox.new(source, target, 'enemy', damage, 0, 30, .1, 'res://assets/images/effects/shadow.png')
		get_parent().add_child(explosion)
		explosion.global_position = area.global_position