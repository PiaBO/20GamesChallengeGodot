extends Node

enum Estado { ESPERANDO, JUGANDO, GAME_OVER }

var estado_actual: Estado = Estado.ESPERANDO
var puntuacion: int = 0
var puntuacion_maxima: int = 0

signal estado_cambiado(nuevo_estado)
signal puntuacion_actualizada(nueva_puntuacion)

func iniciar_juego():
	puntuacion = 0
	estado_actual = Estado.JUGANDO
	estado_cambiado.emit(estado_actual)
	puntuacion_actualizada.emit(puntuacion)

func sumar_punto():
	if estado_actual == Estado.JUGANDO:
		puntuacion += 1
		puntuacion_actualizada.emit(puntuacion)

func terminar_juego():
	if estado_actual != Estado.GAME_OVER: # Evitar llamarlo dos veces
		estado_actual = Estado.GAME_OVER
		estado_cambiado.emit(estado_actual)
		
		if puntuacion > puntuacion_maxima:
			puntuacion_maxima = puntuacion

func reiniciar_juego():
	get_tree().reload_current_scene()
