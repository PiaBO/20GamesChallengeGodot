extends Control

@onready var res_dropdown: OptionButton = $OptionButton
@onready var vol_slider: HSlider = $VolSlider

# Resoluciones soportadas
var resolutions := [
	Vector2i(1280, 720),
	Vector2i(1600, 900),
	Vector2i(1920, 1080)
]

func _ready() -> void:
	# Llenar dropdown de resoluciones
	process_mode = Node.PROCESS_MODE_ALWAYS
	for res in resolutions:
		res_dropdown.add_item("%dx%d" % [res.x, res.y])
	
	# Configurar slider de volumen (Asumiendo bus "Master")
	vol_slider.value = db_to_linear(AudioServer.get_bus_volume_db(0))
	
	# Ocultar al inicio
	visible = false
	GameManager.game_paused.connect(_on_game_paused)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"): # Tecla Escape
		if visible:
			_close_menu()
		else:
			_open_menu()

func _open_menu() -> void:
	GameManager.toggle_pause()
	visible = true

func _close_menu() -> void:
	GameManager.toggle_pause()
	visible = false

func _on_btn_reanudar_pressed() -> void:
	_close_menu()

#func _on_res_dropdown_item_selected(index: int) -> void:
#	GameManager.apply_resolution(resolutions[index])

func _on_vol_slider_value_changed(value: float) -> void:
	GameManager.apply_volume("Master", value)

func _on_btn_menu_principal_pressed() -> void:
	_close_menu()
	GameManager.change_scene(GameManager.MAIN_MENU_PATH)
	
func _on_game_paused(is_paused: bool) -> void:
	visible = is_paused

func _on_vol_slider_drag_started() -> void:
	pass # Replace with function body.

func _on_btn_menu_prinipal_pressed() -> void:
	pass # Replace with function body.


func _on_option_button_item_selected(index: int) -> void:
	GameManager.apply_resolution(resolutions[index])
