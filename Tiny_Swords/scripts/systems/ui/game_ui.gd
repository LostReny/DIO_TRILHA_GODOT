extends CanvasLayer

@onready var time_label: Label = %"Timer Label"
@onready var gold_label: Label = %"Panel2/Gold Label"
@onready var meat_label: Label = %"Panel2/Meat Label"

var time_elapsed : float = 0.0


func _process(delta):
	
	#update timer
	time_elapsed += delta
	var time_elapsed_seconds: int = floori(time_elapsed)
	var seconds: int = time_elapsed_seconds % 60
	var minutes: int = time_elapsed_seconds / 60
	
	time_label.text = "%02d:%02d" % [minutes, seconds]
	
	
	pass
