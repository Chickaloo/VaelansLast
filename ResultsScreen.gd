extends Control

var timetext
var scoretext
var button

var star1
var star2
var star3

var time_elapsed
var mins
var secs
var score
var threshold_bronze
var threshold_silver
var threshold_gold
var level

var time_progress
var score_progress
var time = 0
var IMAGE_STAR_GOLD = preload("res://assets/images/levelselect/goldstar.png")

# So far, we only need to track time elapsed
func set_values(time, gold_remaining, bronze, silver, gold, maxtime, level):
	time_elapsed = time
	mins = time/60
	secs = time%60
	score = gold * maxtime-time
	threshold_bronze = bronze
	threshold_silver = silver
	threshold_gold = gold
	self.level = level
		
	if time_elapsed < threshold_bronze:
		if pd.missionStars[3*level] == 0:
			pd.missionStars[3*level] = 1
			pd.stars += 1
			pd.maxStars += 1
	if time_elapsed < threshold_silver:
		if pd.missionStars[3*level + 1] == 0:
			pd.missionStars[3*level + 1] = 1
			pd.stars += 1
			pd.maxStars += 1
	if time_elapsed < threshold_gold:
		if pd.missionStars[3*level + 2] == 0:
			pd.missionStars[3*level + 2] = 1
			pd.stars += 1
			pd.maxStars += 1

func _ready():
	get_node('/root/Level').gameSpeed = 1
	self.pause_mode = Node.PAUSE_MODE_PROCESS
	get_tree().paused = true
	timetext = get_child(0).get_child(0)
	scoretext = get_child(0).get_child(1)
	button = get_child(0).get_child(3)
	star1 = get_child(1)
	star2 = get_child(2)
	star3 = get_child(3)
	pd.missionUnlocked[level+1] = 1
	button.disabled = true
	pd.writeSaveData()

func _process(delta):
	
	var c = cos(time) * cos(time) * .75 + 1.5
	time += delta
	if time < 1:
		var tempmins = float(1/time) * time_elapsed / 60 
		var tempsecs = int(float(1/time) * time_elapsed) % 60 
		timetext.text = "Time: %02d:%02d" % [tempmins, tempsecs]
	else:
		timetext.text = "Time: %02d:%02d" % [mins, secs]
		if time_elapsed < pd.missionTimes[level] or pd.missionTimes[level] == 0:
			pd.missionTimes[level] = time_elapsed
			print("new best time")
		
	if time > 1 and time < 2:
		scoretext.text = "Score: " + str(int(float(1/(time-1)) * score))
	else:
		scoretext.text = "Score: " + str(score)
		if score < pd.missionScores[level] or pd.missionScores[level] == 0:
			pd.missionScores[level] = score
			print("new highscore")
	
	if time > 2.2 and time_elapsed < threshold_bronze:
		star1.set_texture(IMAGE_STAR_GOLD)
		if pd.missionStars[3*level] == 0:
			pd.missionStars[3*level] = 1
			pd.stars += 1
	if time > 2.4 and time_elapsed < threshold_silver:
		star2.set_texture(IMAGE_STAR_GOLD)
		if pd.missionStars[3*level + 1] == 0:
			pd.missionStars[3*level + 1] = 1
			pd.stars += 1
	if time > 2.6 and time_elapsed < threshold_gold:
		star3.set_texture(IMAGE_STAR_GOLD)
		if pd.missionStars[3*level + 2] == 0:
			pd.missionStars[3*level + 2] = 1
			pd.stars += 1
			
		if pd.missionStars[3*level] == 1:
			star1.modulate = Color(c,c,c)
		if pd.missionStars[3*level + 1] == 1:
			star2.modulate = Color(c,c,c)
		if pd.missionStars[3*level + 2] == 1:
			star3.modulate = Color(c,c,c)
	if time > 3:
		button.disabled = false

func _unhandled_input(event):
	if (event is InputEventKey and event.pressed) or (event is InputEventMouseButton and event.is_pressed()):
		if time < 999:
			time = 999

func _on_GoNext_button_up():
	get_tree().paused = false
	get_tree().change_scene("res://LevelSelect.tscn")
	pd.writeSaveData()