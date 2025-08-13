extends CharacterBody2D

@export var walk_speed := 300.0        # velocidad instantánea (sin aceleración)
@export var max_speed := 450.0         # tope cuando acelerás
@export var acceleration := 900.0      # qué tan rápido “agarra velocidad”
@export var deceleration := 1100.0     # qué tan rápido frena
@onready var sprite = null

func _ready():
	sprite = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	var direction := Input.get_vector("ui_left","ui_right","ui_up","ui_down").normalized()
	var accel_on := Input.is_action_pressed("accelerate")
	
	if direction == Vector2.ZERO:
		# Al soltar: frená (o poné 0 directo)
		velocity = velocity.move_toward(Vector2.ZERO, deceleration * delta)
		sprite.play("still")
	else:
		if accel_on:
			velocity = velocity.move_toward(direction * max_speed, acceleration * delta)
			if direction == Vector2.LEFT || direction == Vector2.RIGHT:
				sprite.play("run")
		else:
			velocity = direction * walk_speed
			if direction == Vector2.LEFT || direction == Vector2.RIGHT:
				sprite.play("move")
		if direction == Vector2.DOWN:
			sprite.play("down")
		elif direction == Vector2.UP:
			sprite.play("up")
		# Solo cambiar flip cuando hay input horizontal
		if direction.x != 0:
			sprite.flip_h = direction.x < 0
			
	move_and_slide()
