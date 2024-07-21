class_name Enemy
extends Node2D

@export var life: int = 10
@export var death_prefab: PackedScene
@export var damage_digit_prefab: PackedScene
@onready var damage_digit_marker =  $Damage_digit_marker

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
	if death_prefab:
		var death_object = death_prefab.instantiate()
		get_parent().add_child(death_object)
		death_object.position = position
	
	queue_free()
	
	pass
