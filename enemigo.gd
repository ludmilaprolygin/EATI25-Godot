extends CharacterBody2D

@onready var speed = 150
@onready var lives: int
@export var max_lives: int = 5
@onready var sprite = null
var target

@export var bar_offset: Vector2 = Vector2(0, -28) # altura de la barra sobre la cabeza
@export var auto_hide_full_bar: bool = true
@export var bar_visible_time: float = 1.2       # segundos visible al recibir daño
@onready var health_bar: Control = $HealthBar
@onready var progress: TextureProgressBar = $HealthBar/TextureProgressBar

signal enemigo_muerto

func _ready():
	add_to_group("Enemigos")
	sprite = $AnimatedSprite2D
	lives = max_lives

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
	_update_bar_value()
	if lives<=0:
		die()
		
func is_enemy():
	pass

func _update_healthbar_position():
	if health_bar != null:
		health_bar.global_position = global_position + bar_offset
		health_bar.rotation = 0.0
		health_bar.scale = Vector2.ONE
	
func _update_bar_value():
	if progress != null:
		progress.value = lives
		if auto_hide_full_bar:
			health_bar.visible = true
			var snap := lives
			var t := get_tree().create_timer(bar_visible_time)
			t.timeout.connect(func ():
				if lives == snap:
					health_bar.visible = (lives != max_lives)
			)

func _process(_delta):
	_update_healthbar_position()

func _defer_hide_bar() -> void:
	var t := get_tree().create_timer(bar_visible_time)
	var lives_snapshot := lives
	t.timeout.connect(func ():
		if lives == lives_snapshot and auto_hide_full_bar:
			health_bar.visible = (lives != max_lives)
	)

func powerup():
	if randf() < 0.05: # 5% de probabilidad
		var kaboom_scene = preload("res://powerupKaboom.tscn")
		var kaboom_instance = kaboom_scene.instantiate()
		kaboom_instance.global_position = global_position
		get_tree().current_scene.add_child(kaboom_instance)

func die():
	target = false
	sprite.play("death")
	$CPUParticles2D.emitting = true
	$AudioStreamPlayer2D.play()
	await get_tree().process_frame
	await get_tree().create_timer(1.0).timeout
	powerup()
	enemigo_muerto.emit()
	queue_free()
