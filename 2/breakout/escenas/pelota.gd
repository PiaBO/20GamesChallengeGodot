extends RigidBody2D

var acelearcion := 200.0
var direccion : Vector2

func _ready() -> void:
	position.x = GameManager.ANCHO_PANTALLA / 2
	position.y = 20
	
	direccion = Vector2(0,1)

func _physics_process(delta: float) -> void:
	var collision = move_and_collide(direccion * acelearcion * delta)
	var collider
	
	if collision:
		acelearcion += 0.050
		collider = collision.get_collider()
		#direccion = direccion_rebote(collider)
		direccion *= Vector2(-1,1) 
	move_and_collide(direccion * acelearcion * delta)	
		
	
func direccion_rebote(collider):
	var pelotaX = position.x
	var jugadorX = collider.position.x
	var dist = pelotaX - jugadorX
	var new_dir = Vector2()
	
	if direccion.x > 0:
		new_dir.x= -1
	else:
		new_dir.x = 1
		
	new_dir *= direccion
		
	return new_dir.normalized()
