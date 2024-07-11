extends Node2D

@export var regeneration: int = 10

@onready var area2D: Area2D = $Area2D


func _ready():
	area2D.body_entered.connect(_on_area_2d_body_entered)
	pass


func _on_area_2d_body_entered(body) -> void:
	
	if body.is_in_group("player"):
		var player: Player = body
		player.heal(regeneration)
		pass
	
	queue_free()
	pass # Replace with function body.
