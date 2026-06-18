extends RigidBody2D

var acelearcion := 1.0

func _ready() -> void:
	position.x = GameManager.ANCHO_PANTALLA / 2
	position.y = 20
	
	linear_velocity = Vector2(0,400)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
