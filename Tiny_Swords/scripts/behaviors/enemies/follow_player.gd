extends CharacterBody2D

@export var speed: float = 1.0
var playerPosition: Vector2 = Vector2(0,0)

func _physics_process(delta: float) -> void:
	
	#posição do jogador - posição do inimigo - normalizada
	var difference = playerPosition - position 
	var input_vector = difference.normalized()
	
	#velocidade
	velocity = input_vector * speed * 100
	# velocity / input vector 
	move_and_slide()
	pass
