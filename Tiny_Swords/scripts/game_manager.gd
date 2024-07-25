extends Node

signal game_over

#ui player
var player: Player
#queremos a posição do jogador 
var player_position: Vector2
var is_game_over : bool = false


func _end_game():
	if is_game_over : return
	is_game_over = true
	game_over.emit()
	pass
