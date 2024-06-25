extends CharacterBody2D


@export var speed = 300.0
@export_range(0,1) var lerp_factor = 0.5

#segurando ctrl e arrastando a sprite para dentro do script
@onready var ship_yellow_manned = %ShipYellowManned

var original_scale = Vector2(1, 1)

func _physics_process(delta):
	
	var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	#velocity = direction * speed * 100
	
	var target_velocity = direction * speed * 100
	velocity = lerp(velocity, target_velocity, lerp_factor)
	move_and_slide()
	
	#lerp
	#linear interpolation
	
	var target_rotation = direction.x * 15.0
	ship_yellow_manned.rotation_degrees = lerp(ship_yellow_manned.rotation_degrees, target_rotation, lerp_factor)
	
	_button_pressed()


func _button_pressed():
	if Input.is_action_pressed("ui_up"):
		var target_scale = Vector2(1, 1.09)
		ship_yellow_manned.scale = lerp(ship_yellow_manned.scale, target_scale, lerp_factor)
		#ship_yellow_manned.scale.y = 2
	elif Input.is_action_pressed("ui_down"):
		var target_scale = Vector2(1, 0.9)
		ship_yellow_manned.scale = lerp(ship_yellow_manned.scale, target_scale, lerp_factor)
		#ship_yellow_manned.scale.y = 2
	else: 
		var target_scale = original_scale
		ship_yellow_manned.scale = lerp(ship_yellow_manned.scale, target_scale, lerp_factor)

