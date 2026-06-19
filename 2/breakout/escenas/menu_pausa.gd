extends Node2D


func _ready() -> void:
# IMPORTANTE: Este nodo debe seguir funcionando aunque el juego esté pausado
	process_mode = Node.PROCESS_MODE_ALWAYS

	GameManager.juego_pausado.connect(_on_juego_pausado)
	visible = false

func _on_juego_pausado(esta_pausado: bool) -> void:
	visible = esta_pausado

func _on_reanudar() -> void:
	GameManager.reanudar_juego()

func _on_reiniciar() -> void:
	GameManager.reiniciar_partida()

func _on_salir() -> void:
	get_tree().quit()

# Detectar tecla ESC para pausar/reanudar
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"): # ESC por defecto
		GameManager.toggle_pausa()
