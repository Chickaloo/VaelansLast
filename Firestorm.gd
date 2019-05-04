class_name Firestorm extends Sprite

var circle
var radius
var duration
var damage
var fireball_cooldown

var IMAGE_CIRCLE = preload("res://assets/images/effects/fireballcircle.png")

func _ready():
	circle = Sprite.new()
	circle.texture = IMAGE_CIRCLE
	circle.z_index = 50
	circle.scale = Vector2(2, 2)
	add_child(circle)
	
	fireball_cooldown = .5
	radius = 64
	duration = 10

func _process(delta):
	duration -= delta
	fireball_cooldown -= delta
	
	var c = cos(duration) * cos(duration) * .5 + 1.5
	circle.modulate = Color(c,c,c)
	
	if fireball_cooldown < 0:
		var randx = randi()%radius * (((randi()%2)*2)-1)
		var randy = randi()%radius * (((randi()%2)*2)-1)
		get_parent().add_child(Fireball.new(self.global_position + Vector2(randx, randy)))
		fireball_cooldown = randf()*.66
	
	if duration < 0:
		queue_free()
	
class Fireball extends Node2D:
	
	var IMAGE_FIREBALL = preload("res://assets/images/effects/fireballanim.png")
	var IMAGE_FIREBALL_SHADOW = preload("res://assets/images/effects/shadow.png")
	
	var fireball_sprite
	var shadow_sprite
	var fps
	var smoketimer
	var speed
	var direction
	var dest
	
	func _init(loc):
		fps = .1
		smoketimer = .01
		
		direction = Vector2(randi()%120-60, 500+randi()%200)
		dest = loc
		
		fireball_sprite = Sprite.new()
		fireball_sprite.hframes = 4
		fireball_sprite.vframes = 1
		fireball_sprite.frame = randi()%4
		fireball_sprite.z_index = 50
		#fireball_sprite.material = CanvasItemMaterial.new()
		#fireball_sprite.material.blend_mode = 1
		fireball_sprite.texture = IMAGE_FIREBALL
		add_child(fireball_sprite)
		
		shadow_sprite = Sprite.new()
		shadow_sprite.texture = IMAGE_FIREBALL_SHADOW
		shadow_sprite.modulate = Color(0, 0, 0, .3)
		shadow_sprite.scale = Vector2(.4, .2)
		add_child(shadow_sprite)
		
		fireball_sprite.global_position = loc - 2 * direction
		fireball_sprite.look_at(loc)
		shadow_sprite.global_position = Vector2(fireball_sprite.global_position.x, loc.y)
		
		
	
	func _process(delta):
		fps -= delta
		smoketimer -= delta
		fireball_sprite.global_position += direction * delta
		shadow_sprite.global_position.x += direction.x * delta
		
		if fps < 0:
			fps = .1
			fireball_sprite.frame = (fireball_sprite.frame + 1)%4
			
		if smoketimer < 0:
			var s = Smoke.new(fireball_sprite.global_position)
			get_parent().get_parent().add_child(s)
			smoketimer = .01
		
		if dest.y - fireball_sprite.global_position.y < 10:
			var hitbox = AreaHitbox.new(null, null, 'enemy', 4, 0, 50, 1, '')
			hitbox.global_position = dest
			get_parent().get_parent().add_child(hitbox)
			var e = Explosion.new(dest + Vector2(0, -10))
			get_parent().get_parent().add_child(e)
			for i in range(randi()%10 + 5):
				var d = Debris.new(dest)
				get_parent().get_parent().add_child(d)
			queue_free()
		
class Smoke extends Sprite:
	var IMAGE_SMOKE_TEXTURE = preload("res://assets/images/effects/shadow.png")
	var color
	var alpha
	
	func _init(p):
		texture = IMAGE_SMOKE_TEXTURE
		z_index = 40
		global_position = p
		alpha = .4
		color = 0
		scale = Vector2(.3,.3)
		modulate = Color(color, color, color, .3)
		
		
	func _process(delta):
		alpha -= delta
		color += 3*delta
		var c = sin(color) * sin(color) * .75
		scale += Vector2(delta, delta)/2
		modulate = Color(c, c, c, alpha)
		
		if alpha < 0:
			queue_free()
			
class Explosion extends Sprite:
	var IMAGE_SMOKE_TEXTURE = preload("res://assets/images/effects/explosionanim.png")
	var time
	var fps
	
	func _init(p):
		texture = IMAGE_SMOKE_TEXTURE
		z_index = 50
		global_position = p
		fps = .0625
		frame = 0
		hframes = 11
		vframes = 1
		time = 1
		scale = Vector2(.4, .4)
		
	func _process(delta):
		fps -= delta
		time -= delta
		if fps < 0:
			fps = .0625
			if frame < 10:
				frame += 1
		if time < 0:
			queue_free()
		
class Debris extends Sprite:
	
	var speed
	var decel = Vector2(.1, 200)
	var lifetime
	var stuff = preload("res://assets/images/effects/debris.png")
	
	func _init(p):
		self.global_position = p
		self.z_index = 40
		speed = Vector2(randi()%300-150, 150 + randi()%100)
		self.set_texture(stuff)
		self.set_scale(Vector2(.5, .5))
		vframes = 1
		hframes = 7
		frame = randi()%7
		lifetime = randf()
		
	func _process(delta):
		self.global_position -= speed * delta
		self.speed -= decel * delta
		self.lifetime -= delta
		
		if lifetime < 0:
			queue_free()