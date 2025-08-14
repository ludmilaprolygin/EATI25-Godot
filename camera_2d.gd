extends Camera2D

@onready var label = $Label
@onready var timer = get_node("../../../Timer")

func _process(delta: float) -> void:
	update_label_text()

func update_label_text():
	label.text = str(int(timer.get_time_left()))
