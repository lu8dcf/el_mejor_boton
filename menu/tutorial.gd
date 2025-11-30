extends Control


func _input(event: InputEvent):
	if event.is_action_pressed("ui_esc") or event.is_action_pressed("jump") or event.is_action_pressed("ui_accept"):
		CambioStage.cambiar_escena("res://juego/inicia.tscn")


func _on_button_pressed() -> void:
	CambioStage.cambiar_escena("res://juego/inicia.tscn")
