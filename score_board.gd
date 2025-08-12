extends Control

@onready var vbox = $VBoxNames

func _ready():
	#print("HERE HERE")
	for i in range(vbox.get_child_count()):
		var label = vbox.get_child(i)
		if i < ScoreManager.scoreboard.size():
			var entry = ScoreManager.scoreboard[i]
			label.text = str(i + 1) + ". " + entry["name"] + " - " + str(int(entry["score"]))
		else:
			label.text = str(i + 1) + ". ---"
		
func refresh():
	for i in range(vbox.get_child_count()):
		var label = vbox.get_child(i)
		if i < ScoreManager.scoreboard.size():
			var entry = ScoreManager.scoreboard[i]
			label.text = str(i + 1) + ". " + entry["name"] + " - " + str(int(entry["score"]))
		else:
			label.text = str(i + 1) + ". ---"
