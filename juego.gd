extends Node2D

@onready var jugador = $Entidades/jugador
@onready var puntos_aparicion = $PuntosAparicion
@onready var contenedor_enemigos = $Enemigos
@onready var timer = $Timer

@export var cantidad_enemigos = 5
@export var tiempo_por_ola = 20.0
@export var delay_entre_olas = 5.0

var ola_activa = false

const ENEMIGO_NORMAL = preload("res://enemigo.tscn")
const ENEMIGO_ESPECIAL = preload("res://enemigo_especial.tscn")
@export var porcentaje_especial = 0.1

func _ready() -> void:
	timer.one_shot = true  # importante
	timer.wait_time = tiempo_por_ola
	timer.timeout.connect(_on_Timer_timeout)
	iniciar_ola()

func iniciar_ola() -> void:
	ola_activa = true
	timer.start()
	spawn_enemigos(cantidad_enemigos)

func spawn_enemigos(cantidad: int) -> void:
	for i in range(cantidad):
		var punto_al_azar = puntos_aparicion.get_children().pick_random()
		invocar_enemigo(punto_al_azar.global_position)
		await get_tree().create_timer(0.7).timeout

func invocar_enemigo(position: Vector2) -> void:
	var enemigo_a_instanciar = ENEMIGO_NORMAL
	if randi() % 100 < porcentaje_especial * 100:
		enemigo_a_instanciar = ENEMIGO_ESPECIAL

	var instancia = enemigo_a_instanciar.instantiate()
	instancia.global_position = position
	instancia.target = jugador
	instancia.enemigo_muerto.connect(_on_enemigo_muerto)
	contenedor_enemigos.add_child(instancia)

func _on_enemigo_muerto() -> void:
	await get_tree().process_frame
	if ola_activa and contenedor_enemigos.get_child_count() == 0:
		await terminar_ola()

func _on_Timer_timeout() -> void:
	if ola_activa:
		# Eliminar enemigos restantes si el tiempo terminó
		for enemigo in contenedor_enemigos.get_children():
			enemigo.queue_free()
		await terminar_ola()

func terminar_ola() -> void:
	ola_activa = false
	timer.stop()
	Global.inc_wave()
	cantidad_enemigos += 2
	await get_tree().create_timer(delay_entre_olas).timeout
	iniciar_ola()
