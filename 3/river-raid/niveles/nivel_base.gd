extends Node2D
class_name NivelBase

@export var velocidad_scroll : float = 150.0
signal nivel_completado()

func _physics_process(delta: float) -> void:
	# Mueve todo el nivel hacia abajo
	position.y += velocidad_scroll * delta
