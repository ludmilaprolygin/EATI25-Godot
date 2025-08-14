extends Node

@onready var nro_oleada = 1

func inc_wave():
	nro_oleada += 1
	
func reset_wave():
	nro_oleada = 1

func get_wave_count():
	return nro_oleada
