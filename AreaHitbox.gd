extends DetectionField

class_name AreaHitbox

var source
var target
var damage
var speed
var radius
var duration

var _singleHit
var _hit = false

func _init(source, target, targetGroup, damage, speed, radius, duration, spritePath, singleHit = false):
	_singleHit = singleHit
	
	var collision = CollisionShape2D.new()
	collision.shape = CircleShape2D.new()
	collision.shape.radius = radius
	add_child(collision)
	
	if spritePath:
		var sprite = Globals.newSprite(radius * 2, radius * 2, spritePath)
		sprite.name = 'Sprite'
		add_child(sprite)
	
	self.source = source
	self.searchGroup = targetGroup
	self.damage = damage
	self.speed = speed
	self.target = target
	self.duration = duration

func _ready():
	if is_instance_valid(source):
		self.position = source.position
	if is_instance_valid(target):
		look_at(target.global_position)
	connect("area_entered", self, 'hit')

func _process(delta: float) -> void:
	#delta *= get_node('/root/Level').gameSpeed
	duration -= delta
	if duration <= 0:
		call_deferred("queue_free")
	move_local_x(speed * delta)
	for area in inside:
		hit(area)
		
func hit(area):
	if _singleHit and _hit:
		return
	
	if searchGroup in area.get_groups():
		area.getHit(self)
		call_deferred("queue_free")
		_hit = true