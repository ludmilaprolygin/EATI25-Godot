extends Sprite2D

const MAX_DISTANCE := 50
@onready var puntaArma = $PuntaArma

@export var cantidad_disparos := 5   # cuántos proyectiles por disparo
@export var spread := 15             # dispersión total en grados

@export var cooldown := 0.5  # segundos entre disparos
@export var recoil_strength := 3.0  # pixeles de retroceso
var tiempo_ultimo_disparo := -cooldown  # para permitir disparo inmediato

func _physics_process(delta):
	var jugador = get_parent()
	var global_mouse_pos = get_global_mouse_position()
	var jugador_pos = jugador.global_position

	var dir = global_mouse_pos - jugador_pos

	if dir.length() > MAX_DISTANCE:
		dir = dir.normalized() * MAX_DISTANCE

	global_position = jugador_pos + dir
	rotation = dir.angle()
	flip_v = dir.x < 0

func lanzar_proyectil():
	const PROYECTIL = preload("res://proyectil.tscn")

	# Ángulo base apuntando al mouse
	var dir_base = (get_global_mouse_position() - puntaArma.global_position).normalized()
	var mitad_spread = spread / 2
	var disparo
	
	for i in range(1, cantidad_disparos):
		disparo = PROYECTIL.instantiate()
		disparo.global_position = puntaArma.global_position
		
		var dir = dir_base
		var random_angle = deg_to_rad(randf_range(-spread, spread))
		dir = dir_base.rotated(random_angle)

		disparo.rotation = dir.angle()
		get_tree().current_scene.add_child(disparo)

func disparar():
	if tiempo_ultimo_disparo >= cooldown:
		lanzar_proyectil()
		tiempo_ultimo_disparo = 0.0
		position += Vector2(-recoil_strength, 0)

func _process(delta):
	tiempo_ultimo_disparo += delta
