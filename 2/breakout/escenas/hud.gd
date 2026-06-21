extends CanvasGroup

@onready var labelPuntos := $LabelPuntos
@onready var labelVidas := $LabelVida
@onready var puesto1 := $Puesto1
@onready var puesto2 := $Puesto2
@onready var puesto3 := $Puesto3

func _ready() -> void:
# Conectamos las señales del GameManager
	GameManager.puntos_cambiaron.connect(_on_puntos_cambiaron)
	GameManager.vidas_cambiaron.connect(_on_vidas_cambiaron)

func _on_puntos_cambiaron(nuevo_total: int) -> void:
	labelPuntos.text = "Puntos: " + str(nuevo_total)

func _on_vidas_cambiaron(nuevo_total: int) -> void:

	match nuevo_total:
		3: labelVidas.text = "<3 <3 <3" 
		2: labelVidas.text = "<3 <3" 
		1: labelVidas.text = "<3" 
		

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
