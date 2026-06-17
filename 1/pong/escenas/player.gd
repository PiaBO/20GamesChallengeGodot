extends StaticBody2D

var movimiento = 0
var velocidad = 200

func _ready() -> void:
	position.x = 212
	position.y = 300
	
func _physics_process(delta: float) -> void:
	movimiento = 0
	if Input.is_action_pressed("arriba"):
		movimiento = -velocidad * delta
	elif Input.is_action_pressed("abajo"):
		movimiento = velocidad * delta
		
	position.y = clamp(position.y + movimiento, 0, 533)
