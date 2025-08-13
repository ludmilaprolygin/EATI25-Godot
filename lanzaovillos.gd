extends Sprite2D

const MAX_DISTANCE := 50
@onready var puntaArma = $PuntaArma

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

func disparar():
	const PROYECTIL = preload("res://proyectil.tscn")
	var disparo = PROYECTIL.instantiate()

	# Posicionar el disparo justo en la punta
	disparo.global_position = puntaArma.global_position

	# Rotar disparo para que apunte al mouse
	disparo.rotation = (get_global_mouse_position() - puntaArma.global_position).angle()

	# Agregar el proyectil a la escena (hermano o padre, según cómo esté tu jerarquía)
	get_tree().current_scene.add_child(disparo)
	
func _process(delta):
	if Input.is_action_just_pressed("disparar"):
		disparar()
