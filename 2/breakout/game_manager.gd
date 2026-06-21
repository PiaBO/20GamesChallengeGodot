extends Node2D

signal puntos_cambiaron(nuevo_total)
signal vidas_cambiaron(nuevo_total)
signal game_over
signal juego_pausado(esta_pausado)
signal nueva_partida


var ANCHO_PANTALLA : int
var ALTO_PANTALLA : int
var puntos := 0
var vidas
var esta_pausado := false

const RUTA_RANKING = "user://ranking.json"
var ranking: Array = []  # Array de diccionarios: [{puntos: 100, nivel: 1}, ...]

func _ready() -> void:
	ANCHO_PANTALLA = get_viewport_rect().size.x
	ALTO_PANTALLA = get_viewport_rect().size.y
	vidas = 3
	
	cargar_ranking()
	
func pausar_juego() -> void:
	esta_pausado = true
	get_tree().paused = true
	juego_pausado.emit(true)	

func reanudar_juego() -> void:
	esta_pausado = false
	get_tree().paused = false
	juego_pausado.emit(false)
	nueva_partida.emit()

func toggle_pausa() -> void:
	if esta_pausado:
		reanudar_juego()
	else:
		pausar_juego()

func sumar_puntos(cantidad: int) -> void:
	puntos += cantidad
	puntos_cambiaron.emit(puntos)

func perder_vida() -> void:
	vidas -= 1
	vidas_cambiaron.emit(vidas)
	if vidas <= 0:
		vidas = 3
		game_over.emit()
		intentar_guardar_puntuacion(puntos, 1)
		
func reiniciar_partida() -> void:
	puntos = 0
	vidas = 3
	puntos_cambiaron.emit(puntos)
	vidas_cambiaron.emit(vidas)
	get_tree().reload_current_scene()

#guardar en fichero
func cargar_ranking() -> void:
	if not FileAccess.file_exists(RUTA_RANKING):
		ranking = []
		return
	
	var archivo = FileAccess.open(RUTA_RANKING, FileAccess.READ)
	var texto = archivo.get_as_text()
	archivo.close()
	
	var json = JSON.new()
	var error = json.parse(texto)
	if error == OK:
		ranking = json.data
	else:
		ranking = []
		push_warning("Error al cargar ranking: " + json.get_error_message())
		
func guardar_ranking() -> void:
	var archivo = FileAccess.open(RUTA_RANKING, FileAccess.WRITE)
	archivo.store_string(JSON.stringify(ranking, "\t"))  # "\t" para formato legible
	archivo.close()

func intentar_guardar_puntuacion(puntos: int, nivel: int = 1) -> bool:
	var nueva = {"puntos": puntos, "nivel": nivel}
	
	# Insertar en la posición correcta (ordenado de mayor a menor)
	ranking.append(nueva)
	ranking.sort_custom(func(a, b): return a.puntos > b.puntos)
	
	# Mantener solo las 3 mejores
	if ranking.size() > 3:
		ranking.resize(3)
	
	guardar_ranking()
	return nueva in ranking

func es_top_3(puntos: int) -> bool:
	if ranking.size() < 3:
		return true
	return puntos > ranking[2].puntos
	
	
