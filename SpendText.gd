extends Label

class_name SpendText

var speed = 100
var decel = 100
var lifetime = speed/decel
var direction = Vector2(0, -1)

func _init(score):
	set_text("-" + str(score) + "g")
	modulate = Color(1, 1, 0)
	
func _process(delta):
	if speed > 0:
		speed -= (decel*delta)
	lifetime -= delta
	
	self.rect_position = self.rect_position + direction * speed * delta
	
	if lifetime < 0:
		queue_free()
		set_process(false)