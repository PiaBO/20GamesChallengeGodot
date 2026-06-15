extends StaticBody2D

var SPEED := 150.0
var 	anchuraVentana: int;
var empezar := false

signal signal_puntuar
signal fin_partida

func _ready() -> void:
	anchuraVentana = get_viewport_rect().size.x
	await get_tree().create_timer(5.0).timeout # Espera 1 segundo
	empezar = true

func _process(delta: float) -> void:
	if !empezar:
		await get_tree().create_timer(5.0).timeout # Espera 1 segundo
		empezar = true
		
	position.x -= delta * SPEED   
	
	if position.x < 0:
		reposicionar()

func reposicionar():   
	var random = RandomNumberGenerator.new()
	var newY := random.randf_range(-55.0,55.0)
	
	position.x = anchuraVentana
	position.y = newY
	
func _on_zona_puntos_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	signal_puntuar.emit()

func _on_area_2d_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	if body.is_in_group("jugador1") or body.is_in_group("jugador"):
		fin_partida.emit()
