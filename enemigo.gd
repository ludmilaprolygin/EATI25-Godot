extends CharacterBody2D

@onready var speed = 250
@onready var lives = 5
var target

signal enemigo_muerto

func _physics_process(delta: float) -> void:
	if target:
		var direction = (target.global_position - global_position).normalized()
		velocity = direction * speed
		move_and_slide()

func recibir_daño():
	lives-=1
	if lives<=0:
		enemigo_muerto.emit()
		queue_free()
