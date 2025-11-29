extends Node
var general_volume = 100.0
var music_volume = 100.0
var sfx_volume = 100.0

		
func set_music_volume(volume: float) -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), linear_to_db(volume))

func set_sfx_volume(volume: float) -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Effects"), linear_to_db(volume))
	
	
