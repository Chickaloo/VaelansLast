extends Sprite

var UpgradesButton
var EquipmentButton

var missionLocX = [200, 400, 700, 900, 1200, 600, 180, 500, 720, 900, 1160, 1290]
var missionLocY = [168, 218, 225, 330, 68, 398, 623, 668, 738, 723, 680, 520]

var flags = []

#var DialogueBox = preload("res://objects/dialogue/Dialogue.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	#UpgradesButton = get_child(0)
	#EquipmentButton = get_child(1)
	
	# If Upgrades hasn't been unlocked
	#if global.missionUnlocked[1] == 0:
	#	UpgradesButton.disabled = true
	
	# If Equipment hasn't been unlocked
	#if global.missionUnlocked[2] == 0:
	#	EquipmentButton.disabled = true
	"""
	for i in range(pd.missionUnlocked.size()):
		if pd.missionUnlocked[i] == 1:
			var flag = Flag.new()
			flag.levelid = i
			flag.global_position = Vector2(missionLocX[i], missionLocY[i])
			get_parent().add_child(flag)
			flags.append(flag)
		else:
			break"""

	#if pd.dialogues[0] == 1:
		#var d = DialogueBox.instance()
		#d.dialogue = Dialogues.TutorialText
	#	add_child(d)

func _unhandled_input(event):
	if event is InputEventKey:
		if event.pressed:
			if event.scancode == KEY_R:
				print("Adding mission")
				for i in range(pd.missionUnlocked.size()):
					if pd.missionUnlocked[i] == 0:
						pd.missionUnlocked[i] = 1
						var flag = Flag.new()
						flag.levelid = i
						flag.global_position = Vector2(missionLocX[i], missionLocY[i])
						get_parent().add_child(flag)
						flags.append(flag)
						print(pd.missionUnlocked)
						break
			if event.scancode == KEY_E:
				print("Removing mission")
				for i in range(pd.missionUnlocked.size()):
					if pd.missionUnlocked[pd.missionUnlocked.size()-1-i] == 1:
						pd.missionUnlocked[pd.missionUnlocked.size()-1-i] = 0
						print(pd.missionUnlocked)
						flags[flags.size()-1].queue_free()
						flags.remove(flags.size()-1)
						break
