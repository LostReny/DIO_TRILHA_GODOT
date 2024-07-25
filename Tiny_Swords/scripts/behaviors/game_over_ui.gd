class_name GameOverUI

extends CanvasLayer

@onready var timer_label : Label = %TimeLabel
@onready var number_label : Label = %NumberLabel

@export var restar_delay: float = 5.0
var restart_cooldown : float
var time_survived : String
var monsters_defeated : int


func _ready():
	timer_label.text = time_survived
	number_label.text = str(monsters_defeated)
	restart_cooldown = restar_delay
	pass
	
func _process(delta):
	restart_cooldown -= delta
	if restart_cooldown <= 0:
		restart_game()
	pass


func restart_game():
	pass
