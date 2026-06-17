extends StaticBody2D 

var velocidad_movimiento = 20 
var sube := true
func _ready() -> void:
	position.x = 1152 - 212
	position.y = 648/2

func _physics_process(delta: float) -> void: 
	var movimiento
	if sube:
		movimiento = -velocidad_movimiento
	else:
		movimiento = velocidad_movimiento
		
	if (position.y+movimiento) < 0:
		sube = false
	if (position.y+movimiento) > 533:
		sube = true

	position.y = clamp(position.y + movimiento, 0, 533)
