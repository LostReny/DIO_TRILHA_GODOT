class_name GameOverUI

extends CanvasLayer

@onready var timer_label : Label = %TimeLabel
@onready var number_label : Label = %NumberLabel

@export var restar_delay: float = 5.0
var restart_cooldown : float


func _ready():
	timer_label.text = GameManager.time_elapsed_string
	number_label.text = str(GameManager.monsters_defeated_counte)
	restart_cooldown = restar_delay
	pass
	
func _process(delta):
	restart_cooldown -= delta
	if restart_cooldown <= 0:
		restart_game()
	pass


func restart_game():
	GameManager.reset()
	get_tree().reload_current_scene()
	pass
