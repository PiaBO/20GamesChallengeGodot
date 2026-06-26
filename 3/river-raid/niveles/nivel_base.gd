extends Node2D
class_name NivelBase

@export var velocidad_scroll : float = 150.0
@onready var labelFuel = $Fuel

func _physics_process(delta: float) -> void:
	if(position.y != GameManager.window_height*3):
		position.y += velocidad_scroll * delta
