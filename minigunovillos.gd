extends Sprite2D

const MAX_DISTANCE := 50
@onready var puntaArma = $PuntaArma

@export var cooldown := 0.1        # 0.1s entre disparos para minigun
@export var recoil_strength := 2.0  # pixelitos de retroceso
@export var spread := 3            # dispersión mínima en grados

var tiempo_ultimo_disparo := 0.0

func _physics_process(delta):
	var jugador = get_parent()
	var dir = (get_global_mouse_position() - jugador.global_position)
	if dir.length() > MAX_DISTANCE:
		dir = dir.normalized() * MAX_DISTANCE

	global_position = jugador.global_position + dir
	rotation = dir.angle()
	flip_v = dir.x < 0

func lanzar_proyectil():
	const PROYECTIL = preload("res://proyectil.tscn")
	var disparo = PROYECTIL.instantiate()

	# Posicionar el proyectil en la punta
	disparo.global_position = puntaArma.global_position

	# Rotar proyectil apuntando al mouse + dispersión mínima
	var dir = (get_global_mouse_position() - puntaArma.global_position).normalized()
	var random_angle = deg_to_rad(randf_range(-spread, spread))
	dir = dir.rotated(random_angle)

	disparo.rotation = dir.angle()
	get_tree().current_scene.add_child(disparo)

func disparar():
	if tiempo_ultimo_disparo >= cooldown:
		lanzar_proyectil()
		tiempo_ultimo_disparo = 0.0
		position += Vector2(-recoil_strength, 0)  # recoil simple

func _process(delta):
	tiempo_ultimo_disparo += delta
