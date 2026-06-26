extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_btn_nueva_partida_pressed() -> void:
	GameManager.delete_save() 
	GameManager.player_data = {"player_pos": Vector2.ZERO, "health": 100} # Datos por defecto
	GameManager.change_scene(GameManager.GAME_PATH)

func _on_btn_salir_pressed() -> void:
		get_tree().quit()

func _on_btn_inicio_pressed() -> void:
	GameManager.change_scene(GameManager.MAIN_MENU_PATH)
