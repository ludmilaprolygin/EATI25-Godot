extends "res://enemigo.gd"

func _ready():
	speed = 250      # más rápido
	lives = 10       # más vida
	sprite = $AnimatedSprite2D
