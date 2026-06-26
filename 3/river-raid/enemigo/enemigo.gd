extends StaticBody2D

var velocidad_scroll : float = 150.0  # Velocidad del scroll del nivel
var radio_orbita : float = 50.0       # Tamaño del círculo
var velocidad_orbita : float = 2.0    # Velocidad de rotación

var tiempo : float = 0.0
var posicion_inicial : Vector2

func _ready() -> void:
	posicion_inicial = position

func _physics_process(delta: float) -> void:
	tiempo += delta
	
	var offset_x = cos(tiempo * velocidad_orbita) * radio_orbita
	
	position.x = posicion_inicial.x + offset_x+ (velocidad_scroll * delta)
	
