extends Node

var enemy : Enemy

@export var speed: float = 1.0

#var animated_sprite2D: AnimatedSprite2D = $AnimatedSprite2D
var animated_sprite2D : AnimatedSprite2D

func _ready():
	# vai pegar o node pai da cena
	enemy = get_parent()
	animated_sprite2D = enemy.get_node("AnimatedSprite2D")
	pass


func _physics_process(_delta: float) -> void:
	
	if GameManager.is_game_over : return
	
	#calculando a direção
	#pega a posição do player através do game manager
	var playerPosition = GameManager.player_position
	
	#posição do jogador - posição do inimigo - normalizada
	var difference = playerPosition - enemy.position 
	var input_vector = difference.normalized()
	
	#movimento player
	#velocidade
	enemy.velocity = input_vector * speed * 100
	# velocity / input vector 
	enemy.move_and_slide()
	
	# girar sprite
	if input_vector.x > 0:
		#desmarcar flip_h do Sprite2D
		animated_sprite2D.flip_h = false
	elif input_vector.x < 0:
		#marcar flip_h do Sprite2D
		animated_sprite2D.flip_h = true
	
	pass


