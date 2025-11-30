extends Label



func setup():
	
	global_position.y += 10  # pequeña compensación inicial
	var tween = create_tween().set_parallel(true)
	tween.tween_property(self, "scale", Vector2(2, 2), 0.5).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "modulate:a", 0.0, 0.6).set_delay(0.3)
	tween.tween_property(self, "global_position:y", global_position.y - 60, 1)
	tween.finished.connect(func(): queue_free())  # lambda Eliminar después de la animación
