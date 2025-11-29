extends Node
class_name Jugador

var _max_health: float = 100.0
var _health: float = _max_health:
	set(value):
		_health = clamp(value, 0, _max_health)
		SignalBus.health_changed.emit(_health)
var _max_oxygen: float = 400.0

var _oxygen: float = _max_oxygen:
	set(value):
		_oxygen = clamp(value, 0, _max_oxygen)
		SignalBus.oxygen_changed.emit(_oxygen)

#nave
var t_repa_nave = 10
var nave_position = Vector2.ZERO

var muere = true

var artefacto = 0

# limites del player
var limite_xp=6000
var limite_xn=100

var dash_recarga: float = 3

func take_damage(amount: float) -> void:
	_health -= amount

func less_oxygen(amount:float) -> void:
	_oxygen -= amount

func heal(amount: float) -> void:
	_health += amount

func reset_health() -> void:
	_health = get_max_health()
	
# getters
func get_health():
	return _health
func get_max_health():
	return _max_health
	
func get_oxygen():
	return _oxygen
