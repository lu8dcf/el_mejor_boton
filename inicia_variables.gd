extends Node




func reiniciarVariables():
	GlobalPlayer.artefacto=0
	
	GlobalMundo.f_gravedad= 1000.0
	GlobalMundo.viento = Vector2(0,0)
	GlobalMundo.wind_speed = 100.0
	
	# personaje:
	GlobalPlayer.heal(GlobalPlayer.get_max_health())
	GlobalPlayer._oxygen = GlobalPlayer._max_oxygen
	
	GlobalPlayer.limite_xn = 100
	GlobalPlayer.limite_xp = 6000
	
	
		
	
		
