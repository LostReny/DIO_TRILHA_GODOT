class_name Player

extends CharacterBody2D

@export_category("Life")
@export var life: int = 100
@export var max_life: int = 100
@export var death_prefab: PackedScene
@export_category("Movement")
@export var speed: float = 2.8
@export_range(0,1) var my_lerp: float = 0.2
@export_category("Sword")
@export var sword_damage: int = 2
@export_category("Ritual")
@export var ritual_damage : int = 1
@export var ritual_interval : float = 30
@export var ritual_scene : PackedScene

@onready var animationPlayer: AnimationPlayer = $AnimationPlayer
@onready var sprite2D: Sprite2D = $Sprite2D
@onready var sword_area: Area2D = $SwordArea
@onready var hitbox_area: Area2D = $HitboxArea
@onready var progress_bar: ProgressBar = $HealphProgressBar

var inputV : Vector2 = Vector2(0,0)
var isRunning: bool = false
var wasRunning: bool = false
var isAttacking : bool = false
var attackCooldown : float = 0.0
var hitboxxCooldown: float = 0.0
var ritualCooldown: float = 0.0


#sinal quando pegar uma carne 
signal meat_collected(value: int)

func _ready():
	GameManager.player = self
	pass

func _process(delta):
	
	#colocando a posição do player no game manager
	GameManager.player_position = position
	
	_readInput()
	
	_attack_cooldown(delta)
	
	_animation()
	
	#sistema de ataque
	if Input.is_action_just_pressed("attack"):
		attack()
	
	#processar o dano
	update_hitbox_detection(delta)
	
	#ritual
	update_ritual(delta)
	
	#progressbar 
	progress_bar.max_value = max_life
	progress_bar.value = life
	
	pass

#movimentar o jogador 
func _physics_process(_delta):
	
	# velocidade
	var new_velocity = inputV * speed * 100
	if isAttacking:
		new_velocity = new_velocity * 0.25 
	velocity = lerp(velocity, new_velocity, my_lerp)
	#move o corpo baseado na velocidade
	move_and_slide()
	pass

#animação do jogador
func _animation():
	
	#tocar animação
	if not isAttacking: 
		if wasRunning != isRunning:
			if isRunning: 
				animationPlayer.play("run")
			else:
				animationPlayer.play("idle")
	
	if not isAttacking:
		#trocar lado da sprite 
		if inputV.x > 0:
			#desmarcar flip_h do Sprite2D
			sprite2D.flip_h = false
		elif inputV.x < 0:
			#marcar flip_h do Sprite2D
			sprite2D.flip_h = true
	pass

#input do jogador 
func _readInput():
	
	#input Vector
	inputV = Input.get_vector("move_left","move_right","move_up","move_down")
	
	#apagar dead_zone inputV
	var _deadZone = 0.15
	if abs(inputV.x) < 0.15: 
		inputV.x = 0.0
	if abs(inputV.y) < 0.15: 
		inputV.y = 0.0
	
	#atualizar isRunning
	wasRunning = isRunning
	isRunning = not inputV.is_zero_approx()
	
	pass

#ataque cooldown
func _attack_cooldown(delta: float):
	#atualizar temporizador do ataque
	if isAttacking:
		attackCooldown -= delta
		if attackCooldown <= 0:
			isAttacking = false
			isRunning = false
			animationPlayer.play("idle")
	
	pass

#ataque do jogador
func attack():
	if isAttacking:
		return
	
	#attack // attack_side_2
	#se pressionar botão mouse 1 vez : pressionando a segundo 
	#em um determinado tempo - segunda animação
	animationPlayer.play("attack")
	
	
	if not isAttacking:
		#atack down e ataque up - animação
		if inputV.y > 0 :
			animationPlayer.play("attack_down")
		elif inputV.y < 0 :
			animationPlayer.play("attack_up")
	
	#configurar temporizador
	attackCooldown = 0.6
	#marcar ataque
	isAttacking = true
	
	pass
	
func deal_damage_to_enemies():
	#usa a area da espada para detectar o corpo físico
	var bodies = sword_area.get_overlapping_bodies()
	for body in bodies:
		if body.is_in_group("enemies"):
			var enemy: Enemy = body
			#direção do enemy para o personagem
			var dir_enemy = (enemy.position - position).normalized()
			var dir_attack : Vector2
			if sprite2D.flip_h:
				dir_attack = Vector2.LEFT
			else:
				dir_attack = Vector2.RIGHT
			if inputV.y > 0 :
				dir_attack = Vector2.DOWN
			elif inputV.y < 0 :
				dir_attack = Vector2.UP
			
			var dot_product = dir_enemy.dot(dir_attack)
			if dot_product >= 0.3:
				enemy.damage(sword_damage)
				#print(dot_product)
			
		pass

	pass
	
func update_hitbox_detection(delta):
	#temporizador
	hitboxxCooldown -= delta
	if hitboxxCooldown > 0: return
	
	#frequencia 
	hitboxxCooldown = 0.5
	
	#detectar inimigos
	var bodies = hitbox_area.get_overlapping_bodies()
	for body in bodies:
		if body.is_in_group("enemies"):
			var enemy: Enemy = body
			var damage_amount = 1
			damage(damage_amount)
		pass
	pass
	
#valor de dano para retirar da vida que temos 
func damage(amount: int) -> void:
	if life <= 0: return
	life -= amount
	print("Player recebeu dano de: ", amount, " . A vida total é de: ", life)
	
	#piscar inimigo
	modulate = Color.RED
	var tween = create_tween()
	tween.set_ease(Tween.EASE_IN)
	tween.set_trans(Tween.TRANS_QUINT)
	tween.tween_property(self,"modulate", Color.WHITE, 0.3)
	
	#processar morte
	if life <= 0 :
		die()
	
	pass

func die() -> void:
	if death_prefab:
		var death_object = death_prefab.instantiate()
		get_parent().add_child(death_object)
		death_object.position = position
	
	print("player morreu")
	queue_free()
	
	pass

func heal(amount: int):
	life += amount
	if life > max_life:
		life = max_life
		pass
	#print("cura de ", amount, "vida de ", life )
	return life
	pass

func update_ritual(delta: float) -> void:
	#atualizar temporizador
	ritualCooldown -= delta
	if ritualCooldown > 0: return
	 
	# resetar temporizador 
	ritualCooldown = ritual_interval
	
	#criar o ritual
	var ritual = ritual_scene.instantiate()
	ritual.damage_amount = ritual_damage
	add_child(ritual)
	
	pass
