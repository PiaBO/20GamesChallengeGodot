extends Node2D

var puntuacion:= 0
var yaJugado := false
@onready var label_puntos = $HUD/labelCuenta


func _ready():
	GameManager.estado_cambiado.connect(_on_estado_cambiado)
	GameManager.puntuacion_actualizada.connect(_on_puntuacion_actualizada)
	
	# Estado inicial visual
	_on_estado_cambiado(GameManager.estado_actual)


func _process(delta: float) -> void:
	if yaJugado:
		$jugador.empezar = false;
		var tubos = $Contenedor_Tubos.get_children()
		for tubo in tubos:
			if tubo.has_signal("signal_puntuar"):
				tubo.empezar = false

func _on_estado_cambiado(nuevo_estado: int):
	if nuevo_estado == GameManager.Estado.ESPERANDO:
		label_puntos.visible = false
		
	elif nuevo_estado == GameManager.Estado.JUGANDO:
		label_puntos.visible = true
		
	elif nuevo_estado == GameManager.Estado.GAME_OVER:
		pass
		#label_game_over.visible = true
		#label_instruccion.visible = true
		#label_instruccion.text = "Pulsa ESPACIO para reiniciar"

func _on_puntuacion_actualizada(nueva_puntuacion: int):
	label_puntos.text = str(nueva_puntuacion)

# Detectamos la tecla para iniciar o reiniciar desde el HUD
func _input(event):
	if event.is_action_pressed("ui_accept"):
		if GameManager.estado_actual == GameManager.Estado.ESPERANDO:
			GameManager.iniciar_juego()
		elif GameManager.estado_actual == GameManager.Estado.GAME_OVER:
			GameManager.reiniciar_juego()

func _on_tubo_puntuado():
	puntuacion += 10
	$HUD/puntos.text = str(puntuacion)


func _on_fin_partida():
	yaJugado = true
	get_tree().change_scene_to_file("res://escenas/game_over.tscn")
