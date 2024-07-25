extends Node

@export var game_ui: CanvasLayer
@export var game_over_ui_template: PackedScene

func _ready():
	GameManager.game_over.connect(trigger_game_over)

func trigger_game_over():
	# Delete game UI 
	if game_ui:
		game_ui.queue_free()
		game_ui = null
	
	# Create game over UI
	if game_over_ui_template:
		var game_over_ui: GameOverUI = game_over_ui_template.instantiate()
		game_over_ui.monsters_defeated = 999
		game_over_ui.time_survived = "00:00"
		add_child(game_over_ui)
	else:
		print("game_over_ui_template is null")
