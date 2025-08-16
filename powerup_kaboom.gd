extends Area2D

@onready var sprite = null

func _ready():
	add_to_group("Powerups")
	sprite = $AnimatedSprite2D
	connect("body_entered", Callable(self, "_on_body_entered"))
	$despawn_timer.one_shot = true        # se dispara solo una vez
	$despawn_timer.wait_time = 10.0       # 10 segundos
	$despawn_timer.connect("timeout", Callable(self, "_on_timer_timeout"))
	$despawn_timer.start()                 # arranca el timer

func _process(delta: float) -> void:
	sprite.play("default")

func _on_body_entered(body):
	if body.is_in_group("Player"):
		_play_sound_once()
		# Recorremos todos los enemigos y los matamos
		for enemigo in get_tree().get_nodes_in_group("Enemigos"):
			if enemigo.has_method("die"):
				enemigo.die()
		queue_free()  # Eliminar el power-up

func _on_timer_timeout():
	queue_free()

func _play_sound_once():
	var player = AudioStreamPlayer2D.new()
	player.stream = $AudioStreamPlayer2D.stream
	get_tree().current_scene.add_child(player)
	player.play()
	await player.finished
	queue_free()
