extends Sprite2D

func _physics_process(delta: float) -> void:
	var jugador = $"../AnimatedSprite2D"
	var direction = Input.get_vector("ui_left","ui_right","ui_up","ui_down")
	var tex = jugador.sprite_frames.get_frame_texture(jugador.animation, jugador.frame)
	if direction != Vector2.ZERO:
		if direction.x > 0:
			flip_h = false
			global_position.x = jugador.global_position.x + tex.get_width()/2 + 30
		elif direction.x < 0: 
			flip_h = true
			global_position.x = jugador.global_position.x - tex.get_width()/2 - 30
		else:
			global_position.x = jugador.global_position.x
