extends Area2D

@onready var anim_player: AnimationPlayer = $AnimationPlayer
@onready var timer = $Timer
@onready var collision = $CollisionShape2D
var estado = 0


func _ready():
	anim_player.play("reset")  # estado inicial
	timer.wait_time = 0.5
	timer.one_shot = true
	timer.timeout.connect(_on_timer_timeout)

func _input(event: InputEvent):
	if event.is_action_pressed("presiona"):
		anim_player.play("pulsar")
		anim_player.seek(anim_player.current_animation_length, true) 
		estado=0
		# fuerza a quedarse en el último frame

	elif event.is_action_released("presiona"):
		anim_player.play("soltar")
		timer.start()
		# cuando termine "soltar", volver a reset
		anim_player.connect("animation_finished", Callable(self, "_on_anim_finished"))

func _on_anim_finished(anim_name: String):
	estado=0
	if anim_name == "soltar":
		anim_player.play("reset")
		


func _on_animation_player_animation_finished(anim_name: String):
	if anim_name == "soltar":
		anim_player.play("reset")

func _process(delta):
	if estado==0:
		collision.position.y = 520
	if estado==1:
		collision.position.y = 400   # mueve hacia arriba
	

	
func _on_timer_timeout():
	estado=1
