extends Node2D

@onready var jugador = $Entidades/jugador
@onready var cantidad_enemigos = 5

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
	instancia_enemigo.enemigo_muerto.connect(check_fin_ola)
	$Enemigos.add_child(instancia_enemigo)

func check_fin_ola():
	await get_tree().process_frame
	if $Enemigos.get_children().is_empty():
		nueva_ola()

func nueva_ola():
	for i in range(0, cantidad_enemigos):
		var puntos = $PuntosAparicion.get_children()
		var punto_al_azar = puntos.pick_random()
		invocar_enemigo(punto_al_azar.global_position)
		await get_tree().create_timer(0.7).timeout
