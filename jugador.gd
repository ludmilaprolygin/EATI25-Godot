extends CharacterBody2D

@export var speed = 300
@onready var sprite = null

func _ready():
	sprite = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	if (Input.is_action_just_pressed("disparar")):
		disparar()
	
	var direction = Input.get_vector("ui_left","ui_right","ui_up","ui_down")
	if direction == Vector2.ZERO:
		sprite.play("still")
	else:
		sprite.play("move")
		if direction.x > 0:
			sprite.flip_h = false
		else: 
			sprite.flip_h = true
			
	velocity = direction*speed
	move_and_slide()

func disparar():
	const PROYECTIL = preload("res://proyectil.tscn")
	var disparo = PROYECTIL.instantiate()
	disparo.global_position = global_position
	get_parent().add_child(disparo)
	disparo.look_at(get_global_mouse_position())
