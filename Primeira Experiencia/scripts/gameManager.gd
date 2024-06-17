extends Node2D

func _input(event):
	#check if event is a left click
	if event is InputEventMouseButton:
		if event.button_index == 1:
			if event.pressed == true:
				print(event)
	pass
