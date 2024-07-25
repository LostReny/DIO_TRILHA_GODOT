extends Node

@export_category("Mobs")
@export var mob_spanner = MobSpanner
@export var mobs_spanned_per_minute : float = 30

@export_category("Wave")
@export var initial_spawn_rate : float = 60
@export var wave_duration : float = 20

@export var break_intensity : float = 0.5

var timer: float = 0.0


func _process(delta):
	#ignorar game over 
	if GameManager.is_game_over : return
	
	timer += delta
	
	#dificuldade linear
	var spawn_rate = initial_spawn_rate + mobs_spanned_per_minute * (timer / 60) 
	
	#onda de dificuldade / linha rosa
	var sin_wave = sin((timer * TAU) / wave_duration)
	var wave_factor = remap(sin_wave, -1.0, 1.0,break_intensity,1)
	spawn_rate *= wave_factor
	
	#linha dificuldade / aplica a dificulade
	mob_spanner.mobs_per_minute = spawn_rate
	
	
	pass
