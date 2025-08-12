extends CharacterBody2D

@onready var sprite = $AnimatedSprite2D
@onready var dog_timer = $"../DogDelayTimer"
@onready var music = $"../Music"
@onready var poop_sound = $PooSound
@onready var poo_label = $"../Points"


var DogScene = preload("res://dog.tscn")
var PoliceScene = preload("res://police.tscn")
#START LOOP

var target_position = Vector2(-940, 30)
var speed = 170
var walking = true
var has_zipped = false
var dog_appeared  = false

#POO LOOP
var pooping = false
var poop_timer = 0.0
var poop_duration = 3.4 #lengh of the whole animation!
var is_screen_pressed := false #for mobile!

const POO_OFFSET = Vector2(0, 45)

#POLICE SPAWN TIMER
var police_spawn := 450
var min_timeadd := 70
var police_timer := 0.0
var police_time_up := 8.0

#POINTS
var poo_counter := 0

func _ready():
	sprite.play("walk")
#	music.play()

func _physics_process(delta):
	if walking:
		var direction = (target_position - position).normalized()
		if position.distance_to(target_position) > 5:
			position += direction * speed * delta
		else:
			walking = false
			zipit()

func zipit():
	sprite.play("unzip")
	await sprite.animation_finished
	has_zipped = true
	#print("Unzipping done")
	sprite.play("stand")

#POO LOOP
func _process(delta):
	
	#POLICE
	#if randi() % 450 == 0 and pooping:
	#	var new_police = PoliceScene.instantiate()
	#	get_tree().current_scene.add_child(new_police)
	if pooping:
		police_timer += delta
		if randi() % int(police_spawn) == 0:
			var new_police = PoliceScene.instantiate()
			get_tree().current_scene.add_child(new_police)
			
			if police_spawn > min_timeadd:
				police_spawn -= police_spawn * delta
	#GAME MECHANIC
	if has_zipped and (Input.is_action_pressed("ui_accept") or is_screen_pressed):
		if not pooping:
			pooping = true
			sprite.play("poo")
			sprite.position += POO_OFFSET
			poop_timer = 0.0
			poop_sound.play()
		else:
			poop_timer += delta
			if poop_timer >= poop_duration and not dog_appeared:
				dog_appeared = true
				trigger_dog()
				
	else:
		if pooping:
			pooping = false
			sprite.play("stand")
			sprite.position -= POO_OFFSET
			dog_appeared = false
			poop_sound.stop() 

#mobiili tuki
func _unhandled_input(event):
	if event is InputEventScreenTouch:
		is_screen_pressed = event.pressed
	
	
func trigger_dog():
	poo_counter += 1
	ScoreManager.current_score = poo_counter
	if poo_label:
		poo_label.text = str(poo_counter)
	var new_dog = DogScene.instantiate()
	new_dog.position = Vector2(-80, 6)
	get_parent().add_child(new_dog)
