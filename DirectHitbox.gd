extends Node

class_name DirectHitbox

var source
var target
var damage

func _init(source, target, damage):
	self.source = source
	self.target = target
	self.damage = damage

func _ready():
	target.getHit(self)
	queue_free()