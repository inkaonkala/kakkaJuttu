extends Node2D

@onready var music = $GameOverMusic
@onready var popup = $NamePopi
@onready var nameinpu = $NamePopi/VBoxContainer/NameInput
@onready var OKbutton = $NamePopi/VBoxContainer/Button
@onready var doggy = $littleDog
@onready var scores = $ScoreBoard

var playerName: String = ""
var can_startagain := false

func _ready():
	music.play()
	
	scores.hide()
	popup.popup_centered()
	OKbutton.pressed.connect(button_OK_press)
	
	var score_board_scene = preload("res://score_board.tscn")
	var score_board = score_board_scene.instantiate()
	add_child(score_board)

	
func button_OK_press():
		playerName = nameinpu.text
		if playerName.length() == 0:
			playerName = "Poopy"
		ScoreManager.add_score(playerName, int(ScoreManager.current_score))
		popup.hide()
#		ScoreManager.add_score(playerName, ScoreManager.current_score)
		scores.refresh()
		scores.show()
		doggy.play("kavely")
		can_startagain = true
		
func _input(event):
	if can_startagain and event.is_action_pressed("ui_accept"):
			MusicManager.start()
			get_tree().change_scene_to_file("res://opening.tscn")
	
