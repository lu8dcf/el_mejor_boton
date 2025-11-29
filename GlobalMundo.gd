extends Node

# para el stage
var en_pausa = false

var min_viento = -1
var max_viento = 1
var min_wind_speed = 100.0
var max_wind_speed = 500.0
var min_f_gravedad = 400.0
var max_f_gravedad = 1500.0

var gravedad = Vector2(0,1)
#var wind_speed = 100.0
#var viento = Vector2(-1,0)
#var f_gravedad = 1000.0

var pantalla_ancho = 960.0
var pantalla_alto = 540.0
var limite_inferior = 520.0

# menu optiones
var ventana = true
var tutorial = true


#setters

var wind_speed: float = 100.0:
	set(value):
		wind_speed = clamp(value, min_wind_speed, max_wind_speed)
		SignalBus.viento_velocidad_cambio.emit(wind_speed)

var viento: Vector2 = Vector2(-1,0):
	set(value):
		var direccion = value.x
		if direccion == 0:
			direccion =1
		else:
			direccion =sign(direccion) #elige entre -1 o 1
		viento = Vector2(direccion,0)
		SignalBus.wind_changed.emit(viento)

var f_gravedad: float = 1000.0:
	set(value):
		f_gravedad = clamp(value, min_f_gravedad, max_f_gravedad)
		SignalBus.force_gravity_changed.emit(f_gravedad)

var estados = {
	# dificultad mas facil - predecible
	1: {
		1: {"wind_speed": 150, "viento_rango": -1, "f_gravedad": 400},  # Muy fácil
		2: {"wind_speed": 200, "viento_rango": 1, "f_gravedad": 500},   # Cambio de dirección
		3: {"wind_speed": 250, "viento_rango": -1, "f_gravedad": 600},  # Un poco más fuerte
		4: {"wind_speed": 300, "viento_rango": 1, "f_gravedad": 700},   # Más desafío
		5: {"wind_speed": 350, "viento_rango": -1, "f_gravedad": 800}   # Desafío moderado
	},
	# DIFICULTAD 2 mas intenso y variable
	2: {
		1: {"wind_speed": 200, "viento_rango": -1, "f_gravedad": 400},   # Como el final de fácil
		2: {"wind_speed": 350, "viento_rango": 1, "f_gravedad": 500},   # Más fuerte
		3: {"wind_speed": 360, "viento_rango": -1, "f_gravedad": 800},  # Muy desafiante
		4: {"wind_speed": 400, "viento_rango": 1, "f_gravedad": 1000},   # Casi máximo
		5: {"wind_speed": 450, "viento_rango": -1, "f_gravedad": 1200}   # Máxima intensidad
	}
	#la dificultad DIFICIL es aleatoria
}



func ataque_aerux():
	var cant_artefacto = min(GlobalPlayer.artefacto, 5) # maximo 5 (4artefactos)
	if GlobalEnemy.dificultad == 3:
		var rango = RandomNumberGenerator.new()
		# sera aleatorio en un rango razonable
		# cambia la velocidad del viento
		wind_speed = rango.randf_range(min_wind_speed,max_wind_speed)
		print("viento velocidad: ", wind_speed)
		# cambia la direccion del viento
		var viento_rango = rango.randi_range(0,1)
		viento = Vector2(viento_rango,0)
		print("viento direccion: ", viento)
		# cambia la gravedad
		f_gravedad= rango.randf_range(min_f_gravedad, max_f_gravedad)
		print("gravedad: ", f_gravedad)
		
	elif GlobalEnemy.dificultad == 1 || GlobalEnemy.dificultad == 2:
		var estado_actual = estados[GlobalEnemy.dificultad][cant_artefacto] # compara en que dificultad estamos y revisa en que artefacto para poner la dificultad de ese stage
		
		wind_speed = estado_actual["wind_speed"]
		print("viento velocidad: ", wind_speed)
		
		var viento_rango = estado_actual["viento_rango"]
		viento = Vector2(viento_rango, 0)
		print("viento direccion: ", viento)
		
		f_gravedad = estado_actual["f_gravedad"]
		print("gravedad: ", f_gravedad)
	else:
		pass 
			
		
