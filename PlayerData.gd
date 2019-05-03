extends Node

var missionUnlocked
var missionScores
var missionStars

var skillsEquipped
var skillLevels

var unitsUnlocked
var unitLevels

var volumeLevel
var starts

var dialogues

var stages = ["res://scenes/TestWorld.tscn"]
var stageDescriptions = [
	"The Prince of Vaelan is finally ready to reclaim his throne. Warm up by slaying the monsters harrassing your Callan hosts.",
	"Archers will not be sufficient for the road. Thankfully, there are mages to help you out..."
]

func _ready():
	loadSaveData()
	print(starts)
	missionStars[2] = 1
	missionStars[1] = 1
	starts += 1
	writeSaveData()

""" 	loadSaveData takes the name of a save file, and loads the
		contents stored inside if any. 
		Return true if successful, and false on fail condition:
			(unreadable, bad format, does not exist, etc)
			
		Arguments
		filepath - string containing the path to savefile
"""
func newGame():
	missionUnlocked = [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
	missionScores = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
	missionStars = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]

	skillsEquipped = []
	skillLevels = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]

	unitsUnlocked = [0, 0, 0, 0, 0, 0]
	unitLevels = [0, 0, 0, 0, 0, 0]
	
	volumeLevel = 10
	starts = 0
	
	dialogues = [0]

func loadSaveData(filepath = "user://savegame.save"):
	var save_game = File.new()
	if not save_game.file_exists("user://savegame.save"):
		print("making new game")
		newGame()
	else:
		save_game.open("user://savegame.save", File.READ)
		var save_data = parse_json(save_game.get_line())
		
		missionUnlocked = save_data["missionUnlocked"]
		missionScores = save_data["missionScores"]
		missionStars = save_data["missionStars"]
		
		skillsEquipped = save_data["skillsEquipped"]
		skillLevels = save_data["skillLevels"]
		
		unitsUnlocked = save_data["unitsUnlocked"]
		unitLevels = save_data["unitLevels"]
		
		volumeLevel = save_data["volumeLevel"]
		starts = save_data["starts"]
		
		dialogues = save_data["dialogues"]
		
		save_game.close()
	
""" 	writeSaveData takes the values stored in memory and writes it
		to a file
"""
func writeSaveData(filepath = "default"):
	var save_data = {
			"missionUnlocked": missionUnlocked,
			"missionScores": missionScores,
			"missionStars": missionStars,
		
			"skillsEquipped": skillsEquipped,
			"skillLevels": skillLevels,
		
			"unitsUnlocked": unitsUnlocked,
			"unitLevels": unitLevels,
				
			"volumeLevel": volumeLevel,
			"starts": starts,
			
			"dialogues": dialogues
		}
		
	var save_game = File.new()
	save_game.open("user://savegame.save", File.WRITE)
	save_game.store_line(to_json(save_data))
	save_game.close()
