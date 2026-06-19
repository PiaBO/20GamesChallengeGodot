extends Node2D

@onready var boton: Button = $Button
@onready var labelPuntos: Label = $Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameManager.game_over.connect(_on_game_over)
	visible = false
	boton.pressed.connect(nueva_partida)

func _on_game_over():
	visible = true
	GameManager.pausar_juego()
	labelPuntos.text = "Puntos conseguidos: "+str(GameManager.puntos)
	
	
func nueva_partida():
	GameManager.reanudar_juego()
	GameManager.reiniciar_partida()
	visible = false
