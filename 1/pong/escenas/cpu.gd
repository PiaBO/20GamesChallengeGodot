extends CharacterBody2D 

var velocidad_movimiento = 400 
var sube := true
func _ready() -> void:
	position.x = 1152/2
	position.y = 648/2

func _physics_process(delta: float) -> void: 
	velocity = Vector2.ZERO

	if sube:
		velocity.y = -velocidad_movimiento
	else:
		velocity.y = velocidad_movimiento
		
	move_and_slide()
	if position.y < 0:
		sube = false
	if position.y > 533:
		sube = true
		
	position.y = clamp(position.y, 0, 533)
