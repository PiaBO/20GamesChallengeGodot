extends StaticBody2D

var velocidad = 1000
var ancho

func _ready() -> void:
	position.x = GameManager.ALTO_PANTALLA - 20
	position.y = GameManager.ANCHO_PANTALLA  /2
	ancho = 140

func _process(delta: float) -> void:
	var movimiento = 0
	if Input.is_action_pressed("ui_left"):
		movimiento = -velocidad * delta
	elif Input.is_action_pressed("ui_right"):
		movimiento = velocidad * delta
		
	position.x = clamp(position.x + movimiento, 70, GameManager.ANCHO_PANTALLA-70) #el pivote esta en la mitad del jugador
