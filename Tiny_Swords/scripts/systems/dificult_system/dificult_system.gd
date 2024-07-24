extends Node

@export_category("Mobs")
@export var mob_spanner = MobSpanner
@export var mobs_spanned_per_minute : float = 30

@export_category("Wave")
@export var wave_duration : float = 20

var timer: float = 0.0


func _process(delta):
	timer += delta
	
	mob_spanner.mobs_per_minute
	
	pass
