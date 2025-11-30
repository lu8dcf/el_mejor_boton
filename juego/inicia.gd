# main scene
extends Node2D

# player
var player = null

#entorno
var background = null 
var suelo = null

#pausa
var pausa = null
# items
var items = null
var factory_enemy = null

#enemy
var aerux = null
var t_aerux : Timer  # temposrizador de cuendo aparece el demonio

#factory enemy
var facto

# particulas
var particulas = null

# etiquetas - indicadores de daño
var label_indicador=preload("res://juego/indicador.tscn")  # Asigna indicador en el Inspector

func _ready() -> void:
	#init_background()
	
	init_pause()

	SignalBus.indicador.connect(indicador)  # indicador en pantalla de numeros 
	init_el_boton()
	

	pausa._unpause_game()


func mostrar_transicion():
	var escena_transicion = preload("res://menu/cambio_stage.tscn").instantiate()
	add_child(escena_transicion)
	escena_transicion.cambio_stage()

func init_el_boton():
	var el_boton = preload("res://juego/el_boton.tscn").instantiate()
	add_child(el_boton)
	#el_boton.cambio_stage()
		
func init_pause():
	pausa= preload("res://menu/pause.tscn").instantiate()
	add_child(pausa)
	#pausa.visible =false

func init_background():  # Inicia el fondo 
	background = preload("res://menu/background.tscn").instantiate()
	#background.position = Vector2(0,0)  # Colocar al jugador en la parte inferior al centro
	add_child(background)  # Agrega el nodo hijo




# indicador de numeros e pantalla
func indicador(tipo: int, amount: float, posicion: Vector2):

	#  nodo de etiqueta
	var label = label_indicador.instantiate()
	label.position = posicion
	# selecciono por el tipo 
	match tipo:
		0:   # recibe daño
			label.text = "-" + str(amount).pad_decimals(0) #valor que se muestra con un decimal
			label.modulate = Color(1, 0, 0)  # rojo
		
		1:   # PU recoleccion de maiz 2, 3 y 4
			label.text = "+" + str((amount)).pad_decimals(0)  #valor que se muestra con un decimal
			label.modulate = Color(1, 0.5, 0) # azul	
			$recolectar_item.play()
		4:   # PU de velocidad del player
			label.text = "+" + str((amount)).pad_decimals(0) + " °/o" #valor que se muestra con un decimal
			label.modulate = Color(0, 1, 0) # verde
			$recolectar_item.play()
			
		5:   # PU de Vida del player
			label.text = "+" + str(amount).pad_decimals(0) #valor que se muestra con un decimal
			label.modulate = Color(1, 0, 0) # rojo
			$recolectar_item.play()
		6:   # PU de Daño del arma
			label.text = "+" + str((amount-1)*100).pad_decimals(0) + "%" #valor que se muestra con un decimal
			label.modulate = Color(1, 1, 0) # amarillo
			$recolectar_item.play()
		7:    # PU de velocidad  de disparo
			label.text = "+" + str((amount-1)*100).pad_decimals(0) + "%" #valor que se muestra con un decimal
			label.modulate = Color(0, 1, 0) # negro
			$recolectar_item.play()
	add_child(label)  # Agrega como hijo del main al enemigo
	label.setup()
	

	
