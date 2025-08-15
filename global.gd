extends Node

@onready var nro_oleada = 1
@export var vida = 100
@onready var timer = $Juego/Timer
@onready var jugador

signal player_damaged

func update_player_health(cantidad):
	vida -= cantidad
	emit_signal("player_damaged")

func inc_wave():
	nro_oleada += 1
	
func reset_wave():
	nro_oleada = 1
	vida = 100

func get_wave_count():
	return nro_oleada
