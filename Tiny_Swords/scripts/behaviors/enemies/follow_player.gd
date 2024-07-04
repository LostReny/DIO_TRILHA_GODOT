extends CharacterBody2D

@export var speed: float = 1.0
@onready var animated_sprite2D: AnimatedSprite2D = $AnimatedSprite2D


func _physics_process(_delta: float) -> void:
	#calculando a direção
	#pega a posição do player através do game manager
	var playerPosition = GameManager.player_position
	
	#posição do jogador - posição do inimigo - normalizada
	var difference = playerPosition - position 
	var input_vector = difference.normalized()
	
	#movimento player
	#velocidade
	velocity = input_vector * speed * 100
	# velocity / input vector 
	move_and_slide()
	
	# girar sprite
	if input_vector.x > 0:
		#desmarcar flip_h do Sprite2D
		animated_sprite2D.flip_h = false
	elif input_vector.x < 0:
		#marcar flip_h do Sprite2D
		animated_sprite2D.flip_h = true
	
	pass


