extends Control

@onready var window_mode_option_button = $HBoxContainer/OptionButton as OptionButton

const WINDOW_MODE_ARRAY : Array[String] = [
	"Windowed",
	"Fullscreen",
	"Borderless Windowed",
	"Borderless Fullscreen",
]

func _ready():
	window_mode_option_button.clear()
	for window_mode in WINDOW_MODE_ARRAY:
		window_mode_option_button.add_item(window_mode)
	
	var window_mode = SettingsManager.get_setting("display", "window_mode")
	window_mode_option_button.selected = window_mode




func _on_option_button_item_selected(index):
	SettingsManager.set_setting("display", "window_mode", index)
