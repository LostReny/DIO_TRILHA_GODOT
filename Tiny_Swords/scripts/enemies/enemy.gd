class_name Enemy
extends Node2D

@export_category("Life")
@export var life: int = 10
@export var death_prefab: PackedScene
@export var damage_digit_prefab: PackedScene


@onready var damage_digit_marker =  $Damage_digit_marker

@export_category("Drops")
@export var drop_chance: float = 0.1
@export var drop_itens: Array[PackedScene]
@export var drop_chances: Array[float]

func ready():
	#damage_digit_prefab = preload("res://scenes/test_scene/damage_digit.tscn")
	pass

#valor de dano para retirar da vida que temos 
func damage(amount: int) -> void:
	life -= amount
	print("Inimigo recebeu dano de: ", amount, " . A vida total é de: ", life)
	
	#piscar inimigo
	modulate = Color.RED
	var tween = create_tween()
	tween.set_ease(Tween.EASE_IN)
	tween.set_trans(Tween.TRANS_QUINT)
	tween.tween_property(self,"modulate", Color.WHITE, 0.3)
	
	
	#criar um damage digit 
	var damage_digit = damage_digit_prefab.instantiate()
	damage_digit.value = amount
	if damage_digit_marker :
		damage_digit.global_position = damage_digit_marker.global_position
	else: 
		damage_digit.global_position = global_position
	get_parent().add_child(damage_digit)
	
	#processar morte
	if life <= 0 :
		die()
	
	pass

func die() -> void:
	#caveira
	if death_prefab:
		var death_object = death_prefab.instantiate()
		get_parent().add_child(death_object)
		death_object.position = position
	
	#drop
	if randf() <= drop_chance:
		drop_item()
	
	queue_free()
	
	pass

func drop_item():
	var drop = get_random_drop_item().instantiate()
	drop.position = position
	get_parent().add_child(drop)
	
	pass


func get_random_drop_item() -> PackedScene:
	#calcular a chance maxima 
	
	if drop_itens.size() == 1:
		return drop_itens[0]
	
	var max_chance: float = 0.0
	for drop_chance in drop_chances: 
		max_chance += drop_chance
	
	var random_value = randf() * max_chance
	
	#girar roleta 
	var needle: float = 0.0
	for i in drop_itens.size():
		var drop_item = drop_itens[i]
		var drop_chance = drop_chances[i] if i < drop_chances.size() else 1
		if random_value <= drop_chance + needle:
			return drop_item
		needle += drop_chance
	
	return drop_itens[0]
	
	pass
