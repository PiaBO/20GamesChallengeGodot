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
						
	var directionH := Input.get_axis("ui_left", "ui_right")
	var directionV := Input.get_axis("ui_up", "ui_down")
	if directionH:
		velocity.x = directionH * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	if directionV:
		velocity.y = directionV * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)	
	
	#TODO: LIMITES PERSONAJE
	##clamp(position.y, GameManager.window_height, 0)
	
	move_and_slide()
