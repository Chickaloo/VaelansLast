extends Node2D

class_name Level

const ENEMY_GROUP = 'enemy'
const ENEMY_BASE_GROUP = 'enemyBase'
const PLAYER_GROUP = 'player'
const PLAYER_BASE_GROUP = 'playerBase'
const BUILD_SITE_GROUP = 'buildSite'
const GROUP_UNIT_GROUP = 'groupUnit'
const ENEMY_UNIT_GROUP = 'enemyUnit'

var Dialogue = preload("res://dialogue/Dialogue.tscn")
var Results = preload("res://ResultsScreen.tscn")
var clock

export(String, FILE, '*.tscn') var openingDialogue
export(String, FILE, '*.tscn') var losingDialogue
export(String, FILE, '*.tscn') var winningDialogue

export(int) var maxtime
export(int) var bronzetimethreshold
export(int) var silvertimethreshold
export(int) var goldtimethreshold
export(int) var levelid

export(int) var playerGold
var tileGrid

var playerBaseCount
var enemyBaseCount

var gameSpeed = 1
var opendialogue

var time_start = 0
var time_now = 0

var camera

var A = AStar.new()

func getClosest2(node, targets):
	var nodePoint = A.get_closest_point(Vector3(node.global_position.x, node.global_position.y, 0))
	var minDist = INF
	var closestTarget = null
	for target in targets:
		var targetPoint = A.get_closest_point(Vector3(target.global_position.x, target.global_position.y, 0))
		var path = A.get_id_path(nodePoint, targetPoint)
		if len(path) < minDist:
			minDist = len(path)
			closestTarget = target
		#elif len(path) == minDist and 
	return closestTarget
	
func getClosest(node, targets):
	var minDist = INF
	var closestTarget = null
	for target in targets:
		if not target._isDead:
			var distance = node.global_position.distance_to(target.global_position)
			if distance < minDist:
				minDist = distance
				closestTarget = target 
	return closestTarget
	
func navigate(node, dest, speed = 1.0):
	var startPos = Vector3(node.global_position.x, node.global_position.y, 0)
	var endPos = Vector3(dest.x, dest.y, 0)
	var closestIDStart = A.get_closest_point(startPos)
	var closestIDEnd = A.get_closest_point(endPos)
	var path = A.get_point_path(closestIDStart, closestIDEnd)
	if len(path) == 0:
		return Vector2(0,0)
	if len(path) == 1:
		return (Vector2(dest.x, dest.y) - node.global_position).clamped(speed)
	var direction = path[1] - startPos
	return Vector2(direction.x, direction.y).clamped(speed)

func _ready():
	time_start = OS.get_unix_time()
	if levelid > 0 and pd.missionScores[levelid] == 0:
		opendialogue = Dialogue.instance()
		opendialogue.dialogue = Dialogues.TutorialText
		add_child(opendialogue)
	
	
	playerBaseCount = len(get_tree().get_nodes_in_group(PLAYER_BASE_GROUP))
	enemyBaseCount = len(get_tree().get_nodes_in_group(ENEMY_BASE_GROUP))
	clock = get_child(1)
	camera = get_child(2)
	

	
func spawn(scenePath):
	var scene = load(scenePath)
	var node = scene.instance()
	add_child(node)
	return node
	
func getClosestFromGroup(node, group):
	pass
	
func _process(delta: float) -> void:
	$Canvas/GoldDisplay.text = 'Gold: ' + str(playerGold)
	
func _unhandled_input(event: InputEvent) -> void:
	if (event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT):
		if $Canvas/ClickOptions.mode == ClickOptions.FIREBALL:
			if playerGold >= 30:
				playerGold -= 30

				#var hitbox = AreaHitbox.new(null, null, ENEMY_GROUP, 10, 0, 50, 1, 'res://fireball.jpg')
				#hitbox.position = get_global_mouse_position()
				var hitbox = Firestorm.new()
				hitbox.global_position = get_global_mouse_position()
				add_child(hitbox)
		elif $Canvas/ClickOptions.mode == ClickOptions.BUILDING:
			var buildSite = spawn('res://BuildSite.tscn')
			buildSite.position = get_global_mouse_position()
		elif $Canvas/ClickOptions.mode == ClickOptions.SELECTION:
			add_child(SelectionField.new())
			
func baseDestroyed(base):
	if PLAYER_BASE_GROUP in base.get_groups():
		playerBaseCount -= 1
		if playerBaseCount == 0:
			
			opendialogue = Dialogue.instance()
			opendialogue.isEnd = true
			opendialogue.dialogue = Dialogues.LossTextGeneric
			get_child(2).add_child(opendialogue)
	else:
		enemyBaseCount -= 1
		if enemyBaseCount == 0:
			time_now = OS.get_unix_time()
			var results = Results.instance()
			results.set_values(time_now-time_start, playerGold, bronzetimethreshold, silvertimethreshold, goldtimethreshold, maxtime, levelid)
			get_child(2).add_child(results)
			
