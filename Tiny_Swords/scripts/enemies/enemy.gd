class_name Enemy
extends Node2D

@export var life: int = 10

#valor de dano para retirar da vida que temos 
func damage(amount: int) -> void:
	life -= amount
	print("Inimigo recebeu dano de: ", amount, " . A vida total é de: ", life)
	
	pass
