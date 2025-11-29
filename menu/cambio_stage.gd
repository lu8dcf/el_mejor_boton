extends CanvasLayer

@onready var animacion : AnimationPlayer = $AnimationPlayer
@onready var stage :CanvasLayer = $"."

# simbolos
@onready var texture_gravity: TextureRect = $ColorRect/HBoxContainer/gravedad/TextureRect
@onready var texture_wind: TextureRect = $ColorRect/HBoxContainer/viento/TextureRect
@onready var texture_direction: TextureRect = $ColorRect/HBoxContainer/direccion/TextureRect


# texturas direccion


# label
@onready var label_stage : Label = $ColorRect/PanelContainer/VBoxContainer/label

func _ready() -> void:
	stage.process_mode = Node.PROCESS_MODE_ALWAYS
	layer = -1
	
	# señales
	SignalBus.wind_changed.connect(_on_wind_changed)
	SignalBus.viento_velocidad_cambio.connect(_on_velocity_wind_changed)
	SignalBus.force_gravity_changed.connect(_actualizar_gravedad)
	SignalBus.toma_artefacto.connect(_on_cambiar_stage)
	
	_actualizar_gravedad(GlobalMundo.f_gravedad)
	_on_velocity_wind_changed(GlobalMundo.wind_speed)
	_on_wind_changed(GlobalMundo.viento)
		

func _process(_delta: float) -> void:
	if GlobalMundo.en_pausa:
		stage.process_mode = Node.PROCESS_MODE_PAUSABLE
	else:
		stage.process_mode = Node.PROCESS_MODE_ALWAYS

func cambio_stage() -> void:
	layer = 1
	get_tree().paused = true
	animacion.play("transicion")
	await  (animacion.animation_finished)
	get_tree().paused = false
	layer = -1

func _on_cambiar_stage() -> void:
	label_stage.text =  "stage "+str(GlobalPlayer.artefacto + 1)

func cambiar_escena(path : String) -> void:
	layer = 1
	print(path)
	# reproducir la animacion
	#animacion.play("transicion_simple")
	#await (animacion.animation_finished)
	get_tree().change_scene_to_file(path)
	#animacion.play_backwards("transicion_simple")
	#await (animacion.animation_finished)
	layer = -1
	
	
	
func _on_velocity_wind_changed(wind_speed:float):
	var viento_nivel : String
	var normalizar_velocidad = (wind_speed - GlobalMundo.min_wind_speed)/(GlobalMundo.max_wind_speed-GlobalMundo.min_wind_speed)
	if normalizar_velocidad <0.33:
		viento_nivel="poco"
	elif normalizar_velocidad < 0.66:
		viento_nivel = "normal"
	else:
		viento_nivel = "mucho"
	


func _on_wind_changed(new_wind: Vector2) -> void:
	var direccion : String
	
	if new_wind.x == -1:
		direccion = "izq"
	elif new_wind.x == 1:
		direccion = "der"
	
	
		

func _actualizar_gravedad(new_gravity)-> void:
	var gravedad_nivel:String
	
	var normalizar_gravedad = (new_gravity - GlobalMundo.min_f_gravedad) / (GlobalMundo.max_f_gravedad - GlobalMundo.min_f_gravedad)
	
	if normalizar_gravedad <0.33:
		gravedad_nivel="poco"
	elif normalizar_gravedad < 0.66:
		gravedad_nivel = "normal"
	else:
		gravedad_nivel = "mucho"

	
