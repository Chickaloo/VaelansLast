extends Node2D

var moneyLabel
var star
var time
var archerStatText
var knightStatText
var mageStatText

func _ready():
	time = 0
	moneyLabel = get_child(1).get_child(0)
	updateMoneyLabel()
	star = get_child(0)

	archerStatText = get_child(2).get_child(0).get_child(3)
	knightStatText = get_child(2).get_child(1).get_child(3)
	mageStatText = get_child(2).get_child(2).get_child(3)
	var id = 0
	archerStatText.text = "%d\n\n%d\n\n%d\n\n%d\n\n%d\n\n%d" % [pd.unitHealth[id], 1, pd.unitDamages[id], pd.unitSizes[id], pd.unitLevels[id], pd.unitCosts[id]]
	get_child(2).get_child(0).get_child(4).text = "(+1)\n\n\n\n(+1)\n\n(+1)\n\n(+1)\n\n(+%d)" % [pd.unitCosts[id]]
	id = 1
	knightStatText.text = "%d\n\n%d\n\n%d\n\n%d\n\n%d\n\n%d" % [pd.unitHealth[id], 5, pd.unitDamages[id], pd.unitSizes[id], pd.unitLevels[id], pd.unitCosts[id]]
	get_child(2).get_child(1).get_child(4).text = "(+3)\n\n(+2)\n\n(+2)\n\n(+1)\n\n(+1)\n\n(+%d)" % [pd.unitCosts[id]]
	id = 2
	mageStatText.text = "%d\n\n%d\n\n%d\n\n%d\n\n%d\n\n%d" % [pd.unitHealth[id], 1, pd.unitDamages[id], pd.unitSizes[id], pd.unitLevels[id], pd.unitCosts[id]]
	get_child(2).get_child(2).get_child(4).text = "(+1)\n\n\n\n(+5)\n\n(+1)\n\n(+1)\n\n(+%d)" % [pd.unitCosts[id]]

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
	var id = 0
	if pd.stars >= pd.unitLevels[id]:
		pd.stars -= pd.unitLevels[id]
		upgradeUnit(id)

func _on_UpgradeKnightButton_pressed():
	var id = 1
	if pd.stars >= pd.unitLevels[id]:
		pd.stars -= pd.unitLevels[id]
		upgradeUnit(id)
	
func _on_UpgradeMage_pressed():
	var id = 2
	if pd.stars >= pd.unitLevels[id]:
		pd.stars -= pd.unitLevels[id]
		upgradeUnit(id)

func upgradeUnit(id):
	pd.unitDamages[id] += 1
	pd.unitSizes[id] += 1
	pd.unitHealth[id] += 1
	pd.unitLevels[id] += 1
	#pd.unitCosts[id] *= 2
	get_child(2).get_child(id).get_child(3).text = "%d\n\n%d\n\n%d\n\n%d\n\n%d\n\n%d" % [pd.unitHealth[id], 1, pd.unitDamages[id], pd.unitSizes[id], pd.unitLevels[id], pd.unitCosts[id]]

	
	updateMoneyLabel()
	pd.writeSaveData()
