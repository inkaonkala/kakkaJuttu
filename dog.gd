extends Node2D

@onready var sprite = $AnimatedSprite2D
@onready var timer = $DogDelayTimer
@onready var bark = $bark

var walkspeed = 100

func _ready():
	sprite.play("stand")
	timer.start()
	
func start_walking():
		visible = true
		sprite.play("stand")
		timer.start()
		

func _on_dog_delay_timer_timeout():
		sprite.play("walk")
		bark.play()
	
func _process(delta):
		if sprite.animation == "walk":
			position.x += walkspeed * delta
			if position.x > 1400:
					queue_free()
					
