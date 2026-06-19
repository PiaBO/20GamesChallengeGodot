extends StaticBody2D

var altura := 50
var anchura := 200
var vida : int
@onready var color_rect: ColorRect = $ColorRect


func recibir_golpe() -> void:
	vida -= 1
	
	match vida:
		2: color_rect.color = Color.ORANGE
		1: color_rect.color = Color.RED
		0:
			var tween = create_tween()
			tween.tween_property(color_rect, "modulate:a", 0.0, 0.2)
			tween.tween_callback(queue_free)
			GameManager.sumar_puntos(10)
			
func asignar_color_aleatorio():
	vida = randi_range(1,3)
	
	match vida:
		1: color_rect.color = Color.RED
		2: color_rect.color = Color.ORANGE
		3: color_rect.color = Color.ROYAL_BLUE
