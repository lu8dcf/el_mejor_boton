extends Node

@warning_ignore("unused_signal")
signal indicador (tipo: int , amount: float, posicion: Vector2)
@warning_ignore("unused_signal")
signal health_changed(new_health: float) # cambio de vida
@warning_ignore("unused_signal")
signal oxygen_changed(new_oxygen: float) # cambio de oxygeno
@warning_ignore("unused_signal")
signal hizo_dash()
@warning_ignore("unused_signal")
signal wind_changed(new_wind:float) # a la izquierda cuando el vector (x <0) y a la derecha cuando es vector ( x>0)
@warning_ignore("unused_signal")
signal toma_artefacto()
@warning_ignore("unused_signal")
signal viento_velocidad_cambio(velocidad_nueva:float) # new_speed - fuerza del viento
# a la izquierda cuando el vector (x <0) y a la derecha cuando es vector ( x>0)
@warning_ignore("unused_signal")
signal force_gravity_changed(new_gravity:float)
