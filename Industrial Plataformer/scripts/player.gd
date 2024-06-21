extends CharacterBody2D


@export var speed = 300.0
@export_range(0,1) var lerp_factor = 0.5


func _physics_process(delta):
	
	var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	#velocity = direction * speed * 100
	
	var target_velocity = direction * speed * 100
	velocity = lerp(velocity, target_velocity, lerp_factor)
	
	#lerp
	#linear interpolation
	
	
	
	move_and_slide()
