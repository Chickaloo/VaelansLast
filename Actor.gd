extends Area2D

class_name Actor

export(float) var maxHealth
var _health

var _isDead = false
var hpsprite
var hpbgsprite

onready var level = get_node('/root/Level')

func _ready():
	$Shape.shape.extents = $Sprite.scale * $Sprite.get_texture().get_size() / 2
	_health = maxHealth
	hpsprite = Sprite.new()
	hpsprite.set_texture(preload("res://hp.png"))
	hpsprite.position = Vector2(0, -20)
	hpsprite.scale.x = 0
	hpsprite.z_index = 10
	add_child(hpsprite)
	hpbgsprite = Sprite.new()
	hpbgsprite.set_texture(preload("res://hp.png"))
	hpbgsprite.position = Vector2(0, -20)
	hpbgsprite.scale.x = 0
	hpbgsprite.modulate = Color(1, 0, 0)
	
	add_child(hpbgsprite)
	
"""func _physics_process(delta: float) -> void:
	for area in get_overlapping_areas():
		var offset = global_position - area.global_position
		if offset.length() == 0:
			offset = Vector2(1, 0)
		translate(offset)"""
	
func getHit(hitbox):
	if not _isDead:
		var dt = DamageText.new(hitbox.damage)
		dt.rect_global_position = self.global_position
		get_parent().add_child(dt)
		hpsprite.scale.x = float(_health/maxHealth)
		hpbgsprite.scale.x = float(1)
		_health -= hitbox.damage
		if _health <= 0:
			die()
	
func die():
	_isDead = true
	
	for i in range(randi()%10 + 4):
		level.add_child(Gib.new(self.global_position))
	call_deferred("queue_free")

class DamageText extends Label:
	
	var speed = 100 + randi()%50
	var decel = 100
	var lifetime = speed/decel
	var direction
	
	func _init(damage, dir = Vector2(0,0)):
		set_text(str(damage))
		direction = dir + Vector2(randf(), randf())
		modulate = Color(1,0,0)
	
	func _process(delta):
		if speed > 0:
			speed -= (decel*delta)
		lifetime -= delta
		
		self.rect_position = self.rect_position + direction * speed * delta
		
		if lifetime < 0:
			queue_free()
			set_process(false)
			
class Gib extends Sprite:
	var speed
	var decel
	var gibtimer = .1
	var lifetime
	var blood = preload("res://blood.png")
	func _init(p):
		self.global_position = p
		self.z_index = 950
		speed = Vector2(randi()%40 - 20, 150 + randi()%100)
		decel = Vector2(.1, 350)
		self.set_texture(blood)
		self.set_scale(Vector2(.2, .2))
		lifetime = randf()
		
	func _process(delta):
		self.global_position -= speed * delta
		self.speed -= decel * delta
		self.lifetime -= delta
		self.gibtimer -= delta
		if gibtimer <= 0:
			gibtimer = .1
			get_parent().add_child(Giblet.new(self.global_position))
		
		if lifetime < 0:
			queue_free()
		
class Giblet extends Sprite:
	var shrink_rate = Vector2(1, 1)
	var blood = preload("res://blood.png")
	var lifetime = 1
	func _init(p):
		self.global_position = p
		self.z_index = 90
		self.set_texture(blood)
		self.set_scale(Vector2(.1, .1))
		self.modulate = Color(.5, .5, .5)
		
	func _process(delta):
		self.global_position -= Vector2(0, -20) * delta
		self.lifetime -= delta
		self.scale = self.scale * .95
		if self.scale.x <= 0.01:
			queue_free()