extends Node2D

func _ready() -> void:
	# Si hay datos cargados, aplícalos aquí
	if GameManager.player_data.has("player_pos"):
		print("Posición cargada: ", GameManager.player_data["player_pos"])

func _input(event: InputEvent) -> void:
	# Guardar con F5
	if event.is_action_pressed("ui_focus_next"): # F5 por defecto en Godot
		GameManager.player_data["player_pos"] = Vector2(100, 200) # Simular posición
		GameManager.save_game()
		
	# Simular Game Over con F6
	if event.is_action_pressed("ui_text_backspace"): 
		GameManager.game_over_triggered.emit()
