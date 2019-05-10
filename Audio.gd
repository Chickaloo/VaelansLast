extends AudioStreamPlayer2D

class_name Audio

func _init(soundPath) -> void:
	stream = load(soundPath)

func _ready():
	connect('finished', self, 'queue_free')
	play()