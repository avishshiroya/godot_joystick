extends CharacterBody2D

@onready var joystick = $"../Camera2D/joystick"

var speed = 300

func _physics_process(_delta: float) -> void:
	var direction = joystick.posVector
	if direction:
		velocity = direction * speed
	else:
		velocity = Vector2.ZERO
		
		
	move_and_slide()
