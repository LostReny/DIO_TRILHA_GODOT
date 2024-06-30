extends CharacterBody2D

@onready var animationPlayer: AnimationPlayer = $AnimationPlayer

var isRunning: bool = false

func _process(delta: float):
	if Input.is_action_just_pressed("move_down"):
		if isRunning:
			animationPlayer.play("idle")
			isRunning = false
		else :
			animationPlayer.play("run")
			isRunning = true
