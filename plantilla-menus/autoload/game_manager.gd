extends Node

# --- SEÑALES---
signal game_paused(is_paused)
signal game_over_triggered

# --- RUTAS DE ESCENAS ---
const MAIN_MENU_PATH := "res://menus/main_menu.tscn"
const GAME_PATH := "res://menus/game.tscn"

# --- RUTAS DE ARCHIVOS ---
const SAVE_PATH := "user://savegame.json"
const SETTINGS_PATH := "user://settings.cfg"

# --- ESTADO DEL JUEGO ---
var is_paused := false
var player_data := {}

func _ready() -> void:
	_load_settings()
	
	game_over_triggered.connect(_on_game_over)

func change_scene(path: String) -> void:
	# Aseguramos despausar al cambiar de escena
	if is_paused:
		toggle_pause()
	get_tree().change_scene_to_file(path)

func toggle_pause() -> void:
	is_paused = !is_paused
	get_tree().paused = is_paused
	game_paused.emit(is_paused)

func save_game() -> void:
	player_data["timestamp"] = Time.get_unix_time_from_system()
	
	var file := FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	if file:
		file.store_string(JSON.stringify(player_data))
		print("Partida guardada.")

func load_game():
	if not FileAccess.file_exists(SAVE_PATH):
		print("No hay partida guardada.")
		return false
		
	var file := FileAccess.open(SAVE_PATH, FileAccess.READ)
	if file:
		var json := JSON.new()
		var error := json.parse(file.get_as_text())
		if error == OK:
			player_data = json.data
			change_scene(GAME_PATH)
			return true
	return false

func has_save_file() -> bool:
	return FileAccess.file_exists(SAVE_PATH)

func delete_save() -> void:
	if FileAccess.file_exists(SAVE_PATH):
		DirAccess.remove_absolute(SAVE_PATH)

# ==========================================
# SISTEMA DE OPCIONES
# ==========================================
func apply_resolution(resolution: Vector2i) -> void:
	print("resolucion cambiada")
	DisplayServer.window_set_size(resolution)
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	_save_setting("video", "resolution", "%dx%d" % [resolution.x, resolution.y])

func apply_volume(bus_name: String, linear_value: float) -> void:
	var bus_index := AudioServer.get_bus_index(bus_name)
	if bus_index != -1:
		AudioServer.set_bus_volume_db(bus_index, linear_to_db(linear_value))
		_save_setting("audio", bus_name, linear_value)

func _save_setting(section: String, key: String, value: Variant) -> void:
	var config := ConfigFile.new()
	config.load(SETTINGS_PATH)
	config.set_value(section, key, value)
	config.save(SETTINGS_PATH)

func _load_settings() -> void:
	var config := ConfigFile.new()
	if config.load(SETTINGS_PATH) == OK:
		# Aplicar Resolución
		var res_str: String = config.get_value("video", "resolution", "1280x720")
		var res_parts := res_str.split("x")
		DisplayServer.window_set_size(Vector2i(int(res_parts[0]), int(res_parts[1])))
		
		# Aplicar Audio
		var master_vol: float = config.get_value("audio", "Master", 1.0)
		apply_volume("Master", master_vol)

# ==========================================
# LÓGICA DE FIN DE JUEGO
# ==========================================
func _on_game_over() -> void:
	# Puedes instanciar un CanvasLayer con el GameOverMenu aquí, 
	# o cambiar a una escena dedicada.
	pass 
