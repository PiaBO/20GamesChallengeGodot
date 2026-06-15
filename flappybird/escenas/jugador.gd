extends CharacterBody2D

@export var gravedad: float = 1200.0
@export var fuerza_salto: float = -450.0
const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var xInicial : int;
var empezar := false

func _ready() -> void:
	var xInicial = 597.0



func _physics_process(delta: float):
	# Solo permitimos saltar si el estado es JUGANDO
	if GameManager.estado_actual == GameManager.Estado.JUGANDO:
		if Input.is_action_just_pressed("ui_accept"):
			velocity.y = fuerza_salto
			
		velocity.y += gravedad * delta
		move_and_slide()
		
	if get_slide_collision_count() > 0:
		GameManager.terminar_juego() 

	  
