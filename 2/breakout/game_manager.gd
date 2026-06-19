extends Node2D

var ANCHO_PANTALLA : int
var ALTO_PANTALLA : int
var puntos := 0
var vidas


signal puntos_cambiaron(nuevo_total)
signal vidas_cambiaron(nuevo_total)
signal game_over

func _ready() -> void:
	ANCHO_PANTALLA = get_viewport_rect().size.x
	ALTO_PANTALLA = get_viewport_rect().size.y
	vidas = 3

func sumar_puntos(cantidad: int) -> void:
	puntos += cantidad
	puntos_cambiaron.emit(puntos)

func perder_vida() -> void:
	vidas -= 1
	vidas_cambiaron.emit(vidas)
	if vidas <= 0:
		game_over.emit()

func reiniciar_partida() -> void:
	puntos = 0
	vidas = 3
	puntos_cambiaron.emit(puntos)
	vidas_cambiaron.emit(vidas)
