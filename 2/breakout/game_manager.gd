extends Node2D

var ANCHO_PANTALLA : int
var ALTO_PANTALLA : int

func _ready() -> void:
	ANCHO_PANTALLA = get_viewport_rect().size.x
	ALTO_PANTALLA = get_viewport_rect().size.y
	
	print(ANCHO_PANTALLA)
	print(ALTO_PANTALLA)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
