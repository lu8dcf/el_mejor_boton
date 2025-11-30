extends Control

@onready var animator: AnimationPlayer = $blur_pausa/animator
@onready var sound_pause_on: AudioStreamPlayer2D = $blur_pausa/bg_overlay/sound_pause_on
@onready var sound_pause_off: AudioStreamPlayer2D = $blur_pausa/bg_overlay/sound_pause_off
@onready var pause_menu: VBoxContainer = $blur_pausa/bg_overlay/VBoxContainer2

var pausa_opciones = null
var is_paused := false

func _ready():
	pause_menu.hide()
	pause_menu.process_mode = Node.PROCESS_MODE_ALWAYS

func _unpause_game():
	GlobalMundo.en_pausa = false
	animator.play("resume_pause_blur") # blur desacivado
	is_paused = false
	sound_pause_off.play()
	pause_menu.hide()
	get_tree().paused = false

func _pause_game():
	GlobalMundo.en_pausa = true
	is_paused = true
	animator.play("pause_blur") # blur activdado
	sound_pause_on.play()
	pause_menu.show()
	get_tree().paused = true


func _input(event: InputEvent):
	if event.is_action_pressed("ui_esc"):
		if !is_paused:	# si no está en pausa --- pausar
			_pause_game()
		else:
			_unpause_game()



func _on_reiniciar_pressed()-> void:
	_unpause_game()  # Quita la pausa antes de cambiar
	IniciaVariables.reiniciarVariables()
	await get_tree().create_timer(0.1).timeout  # Pequeño delay para seguridad
	CambioStage.cambiar_escena("res://scenes/main_scene.tscn")



# BOTONES - Modificados para manejar correctamente la pausa
func _on_menu_pressed() -> void:
	_unpause_game()  # quita la pausa antes de cambiar
	await get_tree().create_timer(0.1).timeout  # Pequeño delay para seguridad
	CambioStage.cambiar_escena("res://scenes/menu/menu.tscn")

func _on_play_pressed() -> void:
	_unpause_game()
	await get_tree().create_timer(0.1).timeout
	CambioStage.cambiar_escena("res://scenes/main_scene.tscn")

func _on_exit_pressed() -> void:
	_unpause_game()
	await get_tree().create_timer(0.1).timeout
	get_tree().quit()


func _on_regresar_pressed() -> void:
	
	_unpause_game()



func _on_opciones_pressed() -> void:
	pause_menu.hide() # ocualtar menu de pausa
	pausa_opciones = preload("res://menu/options.tscn").instantiate()
	pausa_opciones.process_mode = Node.PROCESS_MODE_ALWAYS # obligarlo a que esté siempre funcionando, aunque este en pausa el juego
	add_child(pausa_opciones)
	
func _on_options_closed():
	pause_menu.show() #muestra el menu despues de cerra el menu de opciones
	if pausa_opciones:
		pausa_opciones.queue_free() # sacarlo de la lista de addchild
		pausa_opciones = null
		
		
