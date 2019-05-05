extends Node2D

var moneyLabel
var star
var time

func _ready():
	time = 0
	moneyLabel = get_child(1).get_child(0)
	updateMoneyLabel()
	star = get_child(0)

func _process(delta):
	time += delta
	var c = cos(time) * cos(time) * .75 + 1
	star.modulate = Color(c, c, c)


func _on_ReturnButton_pressed():
	get_tree().change_scene("res://LevelSelect.tscn")


func _on_ResetUpgradesButton_pressed():
	pd.stars = pd.maxStars
	updateMoneyLabel()
	#Undo all changes
	
func updateMoneyLabel():
	moneyLabel.text = "Stars: %d/%d" % [pd.stars, pd.maxStars]

func _on_UpgradeArcherButton_pressed():
	if pd.stars > 0:
		pd.stars -= 1
		upgradeArchers()
	updateMoneyLabel()
	pd.writeSaveData()

func upgradeArchers():
	pass
	
