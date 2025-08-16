extends "res://enemigo.gd"

func _ready():
	add_to_group("Enemigos")
	speed = 250      # más rápido
	lives = 10       # más vida
	sprite = $AnimatedSprite2D
