extends CharacterBody2D

@onready var animationPlayer: AnimationPlayer = $AnimationPlayer
@onready var sprite2D: Sprite2D = $Sprite2D
var isRunning: bool = false
@export var speed: float = 1.0
@export_range(0,1) var my_lerp: float = 0.2

#movimentar o jogador 
func _physics_process(delta):
	#input_vector
	var inputV = Input.get_vector("move_left","move_right","move_up","move_down")
	
	#apagar dead_zone inputV
	var deadZone = 0.15
	if abs(inputV.x) < 0.15: 
		inputV.x = 0.0
	if abs(inputV.y) < 0.15: 
		inputV.y = 0.0
	
	# velocidade
	var new_velocity = inputV * speed * 100
	velocity = lerp(velocity, new_velocity, my_lerp)
	#move o corpo baseado na velocidade
	move_and_slide()
	
	#atualizar isRunning
	var wasRunning = isRunning
	isRunning = not inputV.is_zero_approx()
	
	#tocar animação
	if wasRunning != isRunning:
		if isRunning: 
			animationPlayer.play("run")
		else:
			animationPlayer.play("idle")
	
	#trocar lado da sprite 
	if inputV.x > 0:
		#desmarcar flip_h do Sprite2D
		sprite2D.flip_h = false
	elif inputV.x < 0:
		#marcar flip_h do Sprite2D
		sprite2D.flip_h = true
	pass
	
