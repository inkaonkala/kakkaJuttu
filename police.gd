extends Node2D

@onready var sprite = $Police
@onready var timer = $GameOverTime
@onready var whistle = $Whistle

var target = Vector2(400, 400) # Set this to where you want police to walk to
var origin = Vector2.ZERO
var speed = 250

var approa = true
var busted = false
var walkof = false

func _ready():
	randomize()
	whistle.play()

	var screen_size = get_viewport().get_visible_rect().size

	# Random edge spawn
	var edge = randi() % 4
	match edge:
		0: origin = Vector2(-100, randf() * screen_size.y)     # left
		1: origin = Vector2(screen_size.x + 100, randf() * screen_size.y) # right
		2: origin = Vector2(randf() * screen_size.x, -100)      # top
		3: origin = Vector2(randf() * screen_size.x, screen_size.y + 100) # bottom

	position = origin
	sprite.play("walk")
	timer.start()

func _process(delta):
	if busted:
		return

	if approa:
		var distance = position.distance_to(target)
		var direction = (target - position).normalized()
		position += direction * min(speed * delta, distance)

		if distance < 230:
			approa = false
			if Input.is_action_pressed("ui_accept"):
				busted = true
				sprite.play("fine")
				#print("BUSTED")
				await get_tree().create_timer(0.7).timeout
				MusicManager.stop()
				get_tree().change_scene_to_file("res://game_over.tscn")
			else:
				walkof = true
				sprite.play("walk")

	elif walkof:
		var distance = position.distance_to(origin)
		var direction = (origin - position).normalized()
		position += direction * min(100 * delta, distance)

		if distance < 20:
			queue_free()

#			
