extends Control

func _ready():
	var cant_oleadas = Global.nro_oleada - 1
	if cant_oleadas == 0:
		$Panel/VBoxContainer/Label2.text = "No superaste ni una sola oleada"
	elif cant_oleadas == 1:
		$Panel/VBoxContainer/Label2.text = "Has superado "+str(cant_oleadas)+" oleada"
	else:
		$Panel/VBoxContainer/Label2.text = "Has superado "+str(cant_oleadas)+" oleadas"

func _on_reintentar_pressed() -> void:
	get_tree().change_scene_to_file("res://juego.tscn")
	Global.reset_wave()
