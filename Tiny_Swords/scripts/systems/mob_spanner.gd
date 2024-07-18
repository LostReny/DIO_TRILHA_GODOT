extends Node2D

@export var creatures : Array[PackedScene]

@onready var path_follow_2d: PathFollow2D = %PathFollow2D


func _process(delta):
	#frequencia de monstros por minuto 
	#temporizador (cooldown)
	#instanciar uma criatura aleatoria
	
	pass


func get_point() -> Vector2:
	path_follow_2d.progress_ratio = randf()
	return path_follow_2d.position
	pass
