extends Node2D

var level

var StageNameLabel
var HighScoreLabel
var BestTimeLabel
var LevelDescriptionLabel

var Star1
var Star2
var Star3
var IMAGE_STAR_GOLD = preload("res://assets/images/levelselect/goldstar.png")

var time

func _ready():
	StageNameLabel = get_child(0)
	HighScoreLabel = get_child(5)
	BestTimeLabel = get_child(6)
	LevelDescriptionLabel = get_child(7)
	
	Star1 = get_child(2)
	Star2 = get_child(3)
	Star3 = get_child(4)
	
	time = 0
	
func set_level(level):
	self.level = level
	
	if pd.missionStars[3*level] == 1:
		Star1.texture = IMAGE_STAR_GOLD
		Star1.modulate = Color(2,2,2)
	if pd.missionStars[3*level + 1] == 1:
		Star2.texture = IMAGE_STAR_GOLD
		Star2.modulate = Color(2,2,2)
	if pd.missionStars[3*level + 2] == 1:
		Star3.texture = IMAGE_STAR_GOLD
		Star3.modulate = Color(2,2,2)
		
	StageNameLabel.text = "Stage " + str(level+1)
	HighScoreLabel.text = "Highscore: " + str(pd.missionScores[level])
	#BestTimeLabel.text = "Best Time: " + str(pd.missionTimes[level])
	LevelDescriptionLabel.text = pd.stageDescriptions[level]
	
func _process(delta):
	time += delta
	var c = cos(time) * cos(time) * .75 + 1.5
	
	if pd.missionStars[3*level] == 1:
		Star1.modulate = Color(c,c,c)
	if pd.missionStars[3*level + 1] == 1:
		Star2.modulate = Color(c,c,c)
	if pd.missionStars[3*level + 2] == 1:
		Star3.modulate = Color(c,c,c)