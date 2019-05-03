class_name Dialogues extends Node

var TutorialText
var LossTextGeneric

var PORTRAIT_TEST_1 = preload("res://assets/images/portraits/defaultprofile1.png")
var PORTRAIT_TEST_2 = preload("res://assets/images/portraits/defaultprofile2.png")

func _ready():
	TutorialText = DialogueText.new()
	TutorialText.dialogue_index = 0
	TutorialText.setContent([
		[PORTRAIT_TEST_1,"Scout","Sir! There are three monster spawners here! They have to be destroyed before we continue!"],
		[PORTRAIT_TEST_2,"Prince","Alright... damn. These lands are getting more infected by the minute. Get the archers ready."],
		[PORTRAIT_TEST_1,"Scout","Yes, sir."],
		[PORTRAIT_TEST_2,"Prince","And make sure everyone comes back alive. We need everyone to retake the capitol."],
		[PORTRAIT_TEST_1,"Scout","Yes, sir!"]
	])
	
	LossTextGeneric = DialogueText.new()
	LossTextGeneric.dialogue_index = 1
	LossTextGeneric.setContent([
		[PORTRAIT_TEST_1,"Scout","Sir! We need to leave! Our bases are overrun!"],
		[PORTRAIT_TEST_2,"Prince","... Let's get out of here. We'll strengthen our army and return."]
	])