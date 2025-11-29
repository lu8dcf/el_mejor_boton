extends Control
#option

# Variables para los volúmenes (valores entre 0 y 100)
var general_volume = GlobalAudio.general_volume
var music_volume = GlobalAudio.music_volume
var sfx_volume = GlobalAudio.sfx_volume
@onready var vol_general = $panel_sounds/general/general2
@onready var vol_music = $panel_sounds/musica/musica
@onready var vol_sfx = $panel_sounds/efectos/efectos

#globalenemy.dificultad: int (1,2,3)
var dificultad = GlobalEnemy.dificultad
# Difcultad botones:
@onready var btn_facil = $panel_game/dificultad/HBoxContainer/facil2
@onready var btn_normal = $panel_game/dificultad/HBoxContainer/normal2
@onready var btn_dificil = $panel_game/dificultad/HBoxContainer/dificil2

# botones aceptar y cerrar
@onready var btn_aceptar = $btn_aceptar
@onready var btn_salir = $btn_atras2

# Pantalla
var ventana = GlobalMundo.ventana
@onready var btn_pantalla = $panel_game/pantalla/HBoxContainer/btn_completa2
@onready var btn_ventana = $panel_game/pantalla/HBoxContainer/btn_ventana2

# Tutorial botones:
var tutorial = GlobalMundo.tutorial
@onready var switch_tuto: TextureButton  = $panel_game/tutorial/switch_tuto
@onready var texto_tutorial: Label = $panel_game/tutorial/text_tutorial
@onready var icono_tutorial_on: Texture2D = preload("res://recursos/graficos/menu/switch_tuto.png")
@onready var icono_tutorial_off: Texture2D = preload("res://recursos/graficos/menu/switch_tuto_off.png")

var texto_tuto_on = "quiero tutorial"
var texto_tuto_off = "sin tutorial"


func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	$option.play()
	
		
	# Cargar configuración existente
	
	# Configurar botones de dificultad
	actualizar_dificultad()
	actualizar_pantalla()
	actualizar_tutorial()
	actualizar_sonido()
	update_audio_volume()


# tutorial -----------------------------------------------------

func _on_switch_tuto_pressed():
	tutorial = !tutorial
	actualizar_tutorial()

func actualizar_tutorial():
	var icono = icono_tutorial_on if tutorial else icono_tutorial_off
	var texto_tuto  = texto_tuto_on if tutorial else texto_tuto_off
	
	texto_tutorial.text = texto_tuto
	switch_tuto.texture_normal=icono

func actualizar_sonido():
	
	vol_general.value = general_volume
	vol_music.value = music_volume
	vol_sfx.value = sfx_volume
	# Usar GlobalAudio para el volumen de música
	vol_general.value_changed.connect(_on_master_volume_changed)
	vol_music.value_changed.connect(_on_music_volume_changed)
	vol_sfx.value_changed.connect(_on_sfx_volume_changed)
# -----------------------------------------------------------------


func _on_master_volume_changed(valor: float):
	general_volume = valor
	
	# Volumen general directamente con AudioServer
	AudioServer.set_bus_volume_db(
		AudioServer.get_bus_index("Master"), 
		linear_to_db(valor / 100.0)
	)
	
	
func _on_music_volume_changed(valor: float):
	music_volume = valor
	# Volumen general directamente con AudioServer
	AudioServer.set_bus_volume_db(
		AudioServer.get_bus_index("Music"), 
		linear_to_db(valor / 100.0)
	)
	
func _on_sfx_volume_changed(valor: float):
	sfx_volume = valor
	AudioServer.set_bus_volume_db(
		AudioServer.get_bus_index("Effects"), 
		linear_to_db(valor / 100.0)
	)
	
	

# Función para convertir porcentaje a dB (ajusta según tus necesidades)
func percent_to_db(percent: int) -> float:
	# Convertir de porcentaje (0-100) a dB (rango típico -80 a 0)
	return clamp((percent * 0.8) - 80, -80, 0)



# Grabacion
func _on_btn_atras_2_pressed() -> void:
	get_tree().change_scene_to_file("res://menu/menu.tscn")



# Pantalla
func _on_btn_completa_2_pressed() -> void:
	ventana = false
	actualizar_pantalla()

func _on_btn_ventana_2_pressed() -> void:
	ventana = true
	actualizar_pantalla()
	
func actualizar_pantalla():
	btn_pantalla.button_pressed = not ventana
	btn_ventana.button_pressed = ventana

func aplicar_modo_pantalla():
	pass
	#if ventana:
		## Modo ventana
		#if DisplayServer.window_get_mode() != DisplayServer.WINDOW_MODE_WINDOWED:
			#DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
			#DisplayServer.window_set_size(Vector2i(960, 540))
			#
	#else:
		## Modo pantalla completa
		#if DisplayServer.window_get_mode() != DisplayServer.WINDOW_MODE_FULLSCREEN:
			#DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
			#
	

# Dificultad -------------------------------------------------
func _on_facil_2_pressed() -> void:
	dificultad = 1
	actualizar_dificultad()

func _on_normal_2_pressed() -> void:
	dificultad = 2
	actualizar_dificultad()

func _on_dificil_2_pressed() -> void:
	dificultad = 3
	actualizar_dificultad()

func actualizar_dificultad():
	## Deseleccionar todos los botones primero
	btn_facil.button_pressed = false
	btn_normal.button_pressed = false
	btn_dificil.button_pressed = false
	#
	## Seleccionar el botón correspondiente a la dificultad actual
	match dificultad:
		1:
			btn_facil.button_pressed = true
		2:
			btn_normal.button_pressed = true
		3:
			btn_dificil.button_pressed = true


#Grabar --------------------------------------
func _on_btn_aceptar_pressed() -> void:
	GlobalEnemy.dificultad = dificultad
	GlobalMundo.tutorial = tutorial
	GlobalMundo.ventana = ventana
	GlobalEnemy.calcular_dificultad()
	save_volume_settings()
	aplicar_modo_pantalla()
	get_tree().change_scene_to_file("res://menu/menu.tscn")


func update_audio_volume():
	
	# Aplicar volumen a los buses de audio
	if AudioServer.get_bus_index("Master") != -1:
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), linear_to_db(general_volume/100))
	
	if AudioServer.get_bus_index("Music") != -1:
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), linear_to_db(music_volume/100))
	
	if AudioServer.get_bus_index("Effects") != -1:
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Effects"), linear_to_db(sfx_volume/100))

# guardar los estados de sondido
func save_volume_settings():
	
	GlobalAudio.general_volume = general_volume
	GlobalAudio.music_volume = music_volume
	GlobalAudio.sfx_volume = sfx_volume
	
func _input(event: InputEvent):
	if event.is_action_pressed("ui_esc"):
		queue_free()
	
	
