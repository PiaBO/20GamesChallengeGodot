extends Node2D

var puntuacion:= 0
var yaJugado := false
@onready var labelStart = $HUD/labelCuenta


func _ready():
	cuenta_atras()
	var tubos = $Contenedor_Tubos.get_children()
	for tubo in tubos:
		if tubo.has_signal("signal_puntuar"):
			tubo.signal_puntuar.connect(_on_tubo_puntuado)
			tubo.fin_partida.connect(_on_fin_partida)

func _process(delta: float) -> void:
	if yaJugado:
		cuenta_atras()
		$jugador.empezar = false;
		var tubos = $Contenedor_Tubos.get_children()
		for tubo in tubos:
			if tubo.has_signal("signal_puntuar"):
				tubo.empezar = false

func cuenta_atras():
	labelStart.visible = true
	labelStart.text = "3"
	await get_tree().create_timer(1.0).timeout # Espera 1 segundo
	labelStart.text = "2"
	await get_tree().create_timer(1.0).timeout # Espera 1 segundo
	labelStart.text = "1"
	await get_tree().create_timer(1.0).timeout # Espera 1 segundo
	labelStart.text = "YA"
	await get_tree().create_timer(1.0).timeout # Espera 1 segundo
	labelStart.visible = false
	
func _on_tubo_puntuado():
	puntuacion += 10
	$HUD/puntos.text = str(puntuacion)


func _on_fin_partida():
	yaJugado = true
	get_tree().change_scene_to_file("res://escenas/game_over.tscn")
