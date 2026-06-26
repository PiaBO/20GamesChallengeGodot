extends CharacterBody2D


const SPEED = 300.0
const VELOCIDAD_BALA = 1000.0

@onready var size: int = get_node("CollisionShape2D").shape.extents.x
@onready var bala := preload("res://jugador/bala.tscn")


func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		var disparo = bala.instantiate()
		disparo.global_position = $PuntoDisparo.global_position
		disparo.rotation = rotation
		disparo.linear_velocity = Vector2.UP * VELOCIDAD_BALA

		get_parent().add_child(disparo)
						
	var directionH := Input.get_axis("izq", "der")
	var directionV := Input.get_axis("arriba", "abajo")
	if directionH:
		velocity.x = directionH * SPEED
		GameManager.perder_fuel()
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	if directionV:
		velocity.y = directionV * SPEED
		GameManager.perder_fuel()
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)	

	move_and_slide()
	
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()
		
		if collider.is_in_group("Enemigos"):
			_on_colision_con_enemigo(collider)
			break  
		if collider.is_in_group("Fuel"):
			GameManager.recargar_fuel()
			collider.free()
			break
		if collider.is_in_group("Meta"):
			GameManager.nivel_superado()
func _on_colision_con_enemigo(enemigo: Node) -> void:
	print("¡Colisión con enemigo!")
	GameManager._on_game_over()
