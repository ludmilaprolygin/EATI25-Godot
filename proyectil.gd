extends Area2D

@export var velocidad = 500
@onready var recorrido_max = 1000
@onready var distancia = 0

func _physics_process(delta: float) -> void:
	var direction = Vector2.RIGHT.rotated(rotation)
	position += direction * velocidad * delta
	distancia += velocidad*delta

	if distancia >= recorrido_max:
		queue_free()
		
func _ready() -> void:
	var audio = $AudioStreamPlayer2D
	var random_pitch = randf()
	audio.pitch_scale = audio.pitch_scale - random_pitch
	audio.play()
