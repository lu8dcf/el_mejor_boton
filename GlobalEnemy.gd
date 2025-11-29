extends Node

#danios base
var danio_dragon_base = 10
var danio_rayo_base = 3
var danio_volcan_base = 10
var danio_piedra_base = 3
var danio_meteoro_base = 4

# Dificultad del juego
var dificultad = 2

# Rayo
var velocidad_rayo = 400
var spawn_time = 2.4

#piedra
var velocidad_roca = -600
var spawn_time_roca = 2.4

var danio_dragon = danio_dragon_base * dificultad
var danio_piedra = danio_piedra_base * dificultad
var danio_rayo = danio_rayo_base * dificultad
var danio_volcan = danio_volcan_base * dificultad
var danio_meteoro = danio_meteoro_base * dificultad

func _ready() -> void:
	calcular_dificultad()
	SignalBus.toma_artefacto.connect(toma_artefacto)
	
func calcular_dificultad():
	danio_dragon = danio_dragon_base * dificultad
	danio_piedra = danio_piedra_base * dificultad
	danio_rayo = danio_rayo_base * dificultad
	danio_volcan = danio_volcan_base * dificultad
	danio_meteoro = danio_meteoro_base * dificultad
	
func toma_artefacto():
	GlobalPlayer.artefacto +=1
	print ("global ", GlobalPlayer.artefacto)
	
	
