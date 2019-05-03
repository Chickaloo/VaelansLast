extends Node2D

class_name Globals

static func arrayIntersection(array1, array2):
	var intersection = []
	for x in array1:
		if array2.has(x):
			intersection.append(x)
	return intersection
	
static func minIndex(array: Array):
	var i = 0
	var minI = -1
	var smallest = float('inf')
	while i < len(array):
		if array[i] < smallest:
			minI = i
			smallest = array[i]
		i += 1
	return minI
	
static func newSprite(height, width, spritePath):
	var sprite = Sprite.new()
	sprite.name = 'sprite'
	sprite.set_texture(load(spritePath))
	sprite.scale = calcSpriteScale(sprite, height, width)
	return sprite

static func calcSpriteScale(sprite, height, width):
	var size = sprite.get_texture().get_size()
	var scale = Vector2(width / size.x, height / size.y)
	return scale