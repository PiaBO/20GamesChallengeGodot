extends Control

@onready var btn_continue: Button = $VBoxContainer/BtnContinuar

func _ready() -> void:
	btn_continue.disabled = not GameManager.has_save_file()

func _on_btn_nueva_partida_pressed() -> void:
	GameManager.delete_save() # Opcional: borrar save anterior
	GameManager.player_data = {"player_pos": Vector2.ZERO, "health": 100} # Datos por defecto
	GameManager.change_scene(GameManager.GAME_PATH)

func _on_btn_continuar_pressed() -> void:
	GameManager.load_game()

func _on_btn_salir_pressed() -> void:
	get_tree().quit()
