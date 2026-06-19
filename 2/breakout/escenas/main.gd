extends Node2D

#export permite que se pueda editar estas variables del el editor
@export var escenaBloque: PackedScene = preload("res://escenas/bloques.tscn")
@export var filas := 4
@export var columnas := 5
@export var espaciado_x := 200
@export var espaciado_y := 50
@export var offset_x := 50
@export var offset_y := 100

func _ready() -> void:
	GameManager.nueva_partida.connect(_on_nueva_partida)

	generarNivel()

func generarNivel():
	for fila in range(filas):
		for columna in range(columnas):
			# 20% de probabilidad de que no haya bloque en esta posición 
			if randf() < 0.2:
				continue
			var bloque = escenaBloque.instantiate()
			# Posición en el grid
			bloque.position = Vector2(
				offset_x + columna * espaciado_x,
				offset_y + fila * espaciado_y
			)
			
			add_child(bloque)
			bloque.asignar_color_aleatorio()
	
func _on_nueva_partida():
	generarNivel()
	

	
