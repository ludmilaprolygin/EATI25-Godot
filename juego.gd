extends Node2D

@onready var jugador = $Entidades/jugador
@onready var cantidad_enemigos = 0

func _ready() -> void:
	for i in range(0, cantidad_enemigos):
		var puntos = $PuntosAparicion.get_children()
		var punto_al_azar = puntos.pick_random()
		invocar_enemigo(punto_al_azar.global_position)
		await get_tree().create_timer(0.7).timeout
		
func invocar_enemigo(position: Vector2):
	const ENEMIGO = preload("res://enemigo.tscn")
	var instancia_enemigo = ENEMIGO.instantiate()
	instancia_enemigo.global_position = position
	instancia_enemigo.target = jugador
	$Entidades.add_child(instancia_enemigo)
