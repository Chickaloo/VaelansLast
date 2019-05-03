extends HSlider

func _ready():
	pass

func _process(delta: float) -> void:
	get_child(0).text = str(value)
	get_node('/root/Level').gameSpeed = value