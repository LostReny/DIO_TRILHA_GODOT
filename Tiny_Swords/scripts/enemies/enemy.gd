class_name Enemy
extends Node2D

@export var life: int = 10
@export var death_prefab: PackedScene

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
