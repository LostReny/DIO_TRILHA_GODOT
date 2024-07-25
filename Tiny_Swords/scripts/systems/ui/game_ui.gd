extends CanvasLayer

@onready var time_label: Label = %"Timer Label"
@onready var meat_label: Label = %"Meat Label"


func _process(delta):
	time_label.text = GameManager.time_elapsed_string
	meat_label.text = str(GameManager.meat_count) 
	pass

