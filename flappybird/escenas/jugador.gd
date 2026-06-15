extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var xInicial : int;
var empezar := false

func _ready() -> void:
	var xInicial = 597.0
	
	await get_tree().create_timer(5.0).timeout # Espera 1 segundo
	empezar = true


func _physics_process(delta: float) -> void:

	if !empezar:
		await get_tree().create_timer(5.0).timeout # Espera 1 segundo
		empezar = true		

	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept"):
		velocity.y = JUMP_VELOCITY
		rotate(-15)

	move_and_slide()
		

	  
