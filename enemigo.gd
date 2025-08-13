extends CharacterBody2D

@onready var speed = 150
@onready var lives = 5
@onready var sprite = null
var target

signal enemigo_muerto

func _ready():
	sprite = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	if target:
		var direction = (target.global_position - global_position).normalized()
		velocity = direction * speed
		if direction.x < 0:
			sprite.flip_h = true
		sprite.play("move")
		move_and_slide()

func recibir_daño():
	lives-=1
	if lives<=0:
		target = false
		sprite.play("death")
		await get_tree().process_frame  # Espera un frame para mostrar el cambio
		await get_tree().create_timer(1.0).timeout
		enemigo_muerto.emit()
		queue_free()
