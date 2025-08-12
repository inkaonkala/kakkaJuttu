extends Node2D

const SCORE_FILE := "user://scoreboard.json"
const MAX_NAMES := 8

var scoreboard: Array = []
var current_score = 0

func _ready():
	load_scores()
	
func load_scores():
	if FileAccess.file_exists(SCORE_FILE):
		var file = FileAccess.open(SCORE_FILE, FileAccess.READ)
		var data = file.get_as_text()
		scoreboard = JSON.parse_string(data)
	else:
		scoreboard = [
			{"name": "Poo", "score": 26},
			{"name": "Caca", "score": 15},
			{"name": "Kakka", "score": 14},
			{"name": "💩", "score": 10},
			{"name": "Popó", "score": 6},
			{"name": "똥", "score": 4},
			{"name": "Shitzu", "score": 3},
			{"name": "Turds", "score": 1}
		]
		save_scores()
		
func save_scores():
	var file = FileAccess.open(SCORE_FILE, FileAccess.WRITE)
	file.store_string(JSON.stringify(scoreboard))

func add_score(name: String, score: int):
	scoreboard.append({"name": name, "score": score})
	#sort the scores biggest first!
	scoreboard.sort_custom(func(a, b): return a["score"] > b["score"])
	
	if scoreboard.size() > MAX_NAMES:
		scoreboard.resize(MAX_NAMES)
	save_scores()
	
	
