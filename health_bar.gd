extends Control

@export var offset := Vector2(0, -20) # altura sobre la cabeza
@onready var bar: TextureProgressBar = $TextureProgressBar
func _ready():
	top_level = true  # ignora la rotación/escala del padre
	#bar.show_percentage = false

func setup(max_health: int):
	bar.max_value = max_health
	bar.value = max_health

func set_health(current: int):
	bar.value = clamp(current, 0, int(bar.max_value))

func _process(_delta):
	# Seguir al enemigo (suponiendo que el padre es el Enemy)
	if get_parent():
		global_position = get_parent().global_position + offset
		rotation = 0
		scale = Vector2.ONE
