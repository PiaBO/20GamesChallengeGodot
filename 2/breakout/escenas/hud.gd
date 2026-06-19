extends CanvasGroup

@onready var labelPuntos := $LabelPuntos
@onready var labelVidas := $LabelVida

func _ready() -> void:
# Conectamos las señales del GameManager
	GameManager.puntos_cambiaron.connect(_on_puntos_cambiaron)
	GameManager.vidas_cambiaron.connect(_on_vidas_cambiaron)
	GameManager.game_over.connect(_on_game_over)

func _on_puntos_cambiaron(nuevo_total: int) -> void:
	labelPuntos.text = "Puntos: " + str(nuevo_total)

func _on_vidas_cambiaron(nuevo_total: int) -> void:

	match nuevo_total:
		2: labelVidas.text = "<3 <3" 
		1: labelVidas.text = "<3" 
		

func _on_game_over() -> void:
	# Aquí puedes mostrar un panel de Game Over, pausar, etc.
	labelPuntos.text = "GAME OVER"
