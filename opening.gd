extends Node2D


#func _on_button_pressed():
#	$FartSound.play()
#	await $FartSound.finished
#	#var play_scene = preload("res://play_scene.tscn")
#	get_tree().change_scene_to_file("res://play_scene.tscn")

func _unhandled_input(event):
	if event is InputEventKey and event.pressed and event.keycode == KEY_SPACE:
			start_game()
	if event is InputEventScreenTouch and event.pressed:
			start_game()

#ADD PRESS SCREEN!

func start_game():
		$FartSound.play()
		await $FartSound.finished
#		MusicManager.start()
		#var play_scene = preload("res://play_scene.tscn")
		get_tree().change_scene_to_file("res://play_scene.tscn")
