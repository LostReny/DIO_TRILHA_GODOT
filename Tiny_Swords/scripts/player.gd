extends CharacterBody2D

@onready var animationPlayer: AnimationPlayer = $AnimationPlayer
@onready var sprite2D: Sprite2D = $Sprite2D
@export var speed: float = 1.0
@export_range(0,1) var my_lerp: float = 0.2

var isRunning: bool = false
var isAttacking : bool = false
var attackCooldown : float = 0.0


func _process(delta):
	#atualizar temporizador do ataque
	if isAttacking:
		attackCooldown -= delta
		if attackCooldown <= 0:
			isAttacking = false
			isRunning = false
			animationPlayer.play("idle")
	pass

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
	if isAttacking:
		new_velocity = new_velocity * 0.25 
	velocity = lerp(velocity, new_velocity, my_lerp)
	#move o corpo baseado na velocidade
	move_and_slide()
	
	#atualizar isRunning
	var wasRunning = isRunning
	isRunning = not inputV.is_zero_approx()
	
	#tocar animação
	if not isAttacking: 
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
	
	#sistema de ataque
	if Input.is_action_just_pressed("attack"):
		attack()
	pass

#ataque do jogador
func attack():
	if isAttacking:
		return
	
	#attack // attack_side_2
	
	animationPlayer.play("attack")
	
	#configurar temporizador
	attackCooldown = 0.6
	#marcar ataque
	isAttacking = true
	
	
	pass
