extends CanvasLayer

func updateVidaLabel():
	$VidaLabel.text = "Vida: "+str(int(Global.vida))

func updateScoreLabel():
	$ScoreLabel.text = "Oleada: "+str(Global.nro_oleada)

func _physics_process(delta: float) -> void:
	updateVidaLabel()
	updateScoreLabel()
