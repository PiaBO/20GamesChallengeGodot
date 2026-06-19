extends CharacterBody2D

var velocidad_base := 400.0
var velocidad_actual := velocidad_base
var factor_aceleracion := 1.03 
var velocidad_maxima := 1200.0 

func _ready() -> void:
	resetPelota()

func _physics_process(delta: float) -> void:
	var collision = move_and_collide(velocity * delta)
	
	if position.y > GameManager.ALTO_PANTALLA: 
		GameManager.perder_vida()
		resetPelota()
	elif collision:
		var collider = collision.get_collider()
		
		velocidad_actual = min(velocidad_actual * factor_aceleracion, velocidad_maxima)
		
		if collider.has_method("recibir_golpe"):
			collider.recibir_golpe()			
		if collider.is_in_group("jugador"): 
			_rebote_paleta(collider)
		else:
			velocity = velocity.bounce(collision.get_normal()) 
			velocity = velocity.normalized() * velocidad_actual

func resetPelota():
	velocity = Vector2(0,0)
	position.x = GameManager.ANCHO_PANTALLA / 2
	position.y = 400 
	await get_tree().create_timer(2.0).timeout


	var direccion_inicial = Vector2(1, 1).normalized()
	velocity = direccion_inicial * velocidad_actual

func _rebote_paleta(paleta):
	
	var ancho_paleta = paleta.ancho 
	var distancia_relativa = (position.x - paleta.position.x) / (ancho_paleta / 2.0)
	
	distancia_relativa = clamp(distancia_relativa, -0.95, 0.95)
	
	var angulo_maximo = PI / 2.5 
	var angulo_rebote = distancia_relativa * angulo_maximo
	var nueva_direccion = Vector2(sin(angulo_rebote), -cos(angulo_rebote))
	
	velocity = nueva_direccion.normalized() * velocidad_actual
