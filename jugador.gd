extends CharacterBody2D

var speed = 300

func _physics_process(delta: float) -> void:
	var direction = Input.get_vector("ui_left","ui_right","ui_up","ui_down")
	if direction == Vector2.ZERO:
		$AnimatedSprite2D.play("still")
	else:
		$AnimatedSprite2D.play("move")
		if direction.x > 0:
			$AnimatedSprite2D.flip_h = false
		else: 
			$AnimatedSprite2D.flip_h = true
	velocity = direction*speed
	move_and_slide()
