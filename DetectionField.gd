extends Area2D

var inside = []
export(String) var searchGroup

class_name DetectionField

func _ready():
	for area in get_overlapping_areas():
		entered(area)
	connect('area_entered', self, 'entered')
	connect('area_exited', self, 'exited')
	
func entered(area):
	if searchGroup in area.get_groups():
		inside.append(area)

func exited(area):
	if area in inside:
		inside.erase(area)

func getClosest():
	return get_node('/root/Level').getClosest(self, inside)