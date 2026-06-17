extends CharacterBody2D 
var velocidad_movimiento = 400 # Ajusta este valor a lo que necesites (tu "5" escalado)

func _ready() -> void:
	position.x = 212
	position.y = 300

func _physics_process(delta: float) -> void: # 2. Cambiado a physics_process
	velocity = Vector2.ZERO
	
	if Input.is_action_pressed("arriba"):
		velocity.y = -velocidad_movimiento
	elif Input.is_action_pressed("abajo"):
		velocity.y = velocidad_movimiento
		
	move_and_slide()
	position.y = clamp(position.y, 0, 533)
