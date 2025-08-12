extends Node2D

@onready var music_player = $GameMusic

func stop():
	music_player.stop()
	
func start():
	music_player.play()
