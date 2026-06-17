extends RigidBody2D

var velocidad 

func _ready() -> void:
	position.x = 1152/2
	position.y = 648/2

	velocidad = Vector2(400, 400)
	linear_velocity = velocidad
	
func _process(delta: float) -> void:
	pass

func empezar():
	pass
