extends Node2D

@onready var boton: Button = $Button
@onready var labelPuntos: Label = $Label
@onready var puesto1 := $Puesto1
@onready var puesto2 := $Puesto2
@onready var puesto3 := $Puesto3

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	GameManager.game_over.connect(_on_game_over)
	visible = false
	boton.pressed.connect(nueva_partida)

func _on_game_over():
	visible = true
	GameManager.pausar_juego()
	labelPuntos.text = "Puntos conseguidos: "+str(GameManager.puntos)
	
	
func nueva_partida():
	print("pulsado")
	GameManager.reanudar_juego()
	GameManager.reiniciar_partida()
	visible = false
	

func actualizar_ranking() -> void:
	var ranking = GameManager.ranking
	
	# Puesto 1
	if ranking.size() > 0:
		puesto1.text = str(ranking[0].puntos) + " pts (Nivel " + str(ranking[0].nivel) + ")"
	else:
		puesto1.text = "---"
	
	# Puesto 2
	if ranking.size() > 1:
		puesto2.text = str(ranking[1].puntos) + " pts (Nivel " + str(ranking[1].nivel) + ")"
	else:
		puesto2.text = "---"
	
	# Puesto 3
	if ranking.size() > 2:
		puesto3.text = str(ranking[2].puntos) + " pts (Nivel " + str(ranking[2].nivel) + ")"
	else:
		puesto3.text = "---"
