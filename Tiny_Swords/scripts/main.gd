extends Node

@export var game_ui : CanvasLayer
@export var game_over_ui_template : PackedScene


func _ready():
	GameManager.game_over.connect(trigger_game_over())
	pass

func trigger_game_over():
	# deletar game ui 
	if game_ui:
		game_ui.queue_free()
		game_ui = null
	
	#criar game over ui
	var game_over_ui: GameOverUI = game_over_ui_template.instantiate()
	game_over_ui.monsters_defeated = 999
	game_over_ui.time_survived = "00:00"
	add_child(game_over_ui)
	pass
