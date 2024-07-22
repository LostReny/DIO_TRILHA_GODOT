extends CanvasLayer

@onready var time_label: Label = %"Timer Label"
@onready var meat_label: Label = %"Meat Label"

var time_elapsed : float = 0.0
var meat_count : int = 0

func _ready():
	GameManager.player.meat_collected.connect(on_meat_collected)
	meat_label.text = str(meat_count) 
	pass

func _process(delta):
	
	#update timer
	time_elapsed += delta
	var time_elapsed_seconds: int = floori(time_elapsed)
	var seconds: int = time_elapsed_seconds % 60
	var minutes: int = time_elapsed_seconds / 60
	
	time_label.text = "%02d:%02d" % [minutes, seconds]
	pass

func on_meat_collected(regeneration_value: int) -> void:
	meat_count += 1
	meat_label.text = str(meat_count) 
	pass
