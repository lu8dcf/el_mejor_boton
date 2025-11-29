extends Node2D
var credit = null

func _ready() -> void:
	
	$AnimationPlayer.play("creditos")
	tiempo()
	


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://menu/menu.tscn")



func _on_animation_player_animation_finished() -> void:
	get_tree().change_scene_to_file("res://menu/menu.tscn")

func tiempo():
	credit = Timer.new()
	add_child(credit)
	credit.wait_time = 60 # cada 1 segundos cambian los parametros
	
	credit.timeout.connect(_on_animation_player_animation_finished)
	credit.start()
