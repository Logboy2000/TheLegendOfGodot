extends Node

var settings_path = "user://settings.ini"
var config = ConfigFile.new()

# Define default values
const DEFAULT_SETTINGS = {
	"display": {"window_mode": 0, "vsync": true},
	"audio": {"master_volume": 0.5},
	"general": {"language": "en"}
}

func _ready():
	if not load_settings():
		load_defaults()
		save_settings()  # Save default settings to file
	apply_settings()

func load_settings() -> bool:
	var error = config.load(settings_path)
	if error == OK:
		return true
	else:
		print("Settings file not found or could not be loaded.")
		return false

func load_defaults():
	for section in DEFAULT_SETTINGS.keys():
		for key in DEFAULT_SETTINGS[section].keys():
			config.set_value(section, key, DEFAULT_SETTINGS[section][key])
	apply_settings()

func save_settings():
	var error = config.save(settings_path)
	if error != OK:
		print("Failed to save settings.")

func apply_settings():
	apply_display_settings()
	apply_audio_settings()
	apply_general_settings()

func apply_display_settings():
	#region Window Mode
	var window_mode = config.get_value("display", "window_mode", DEFAULT_SETTINGS["display"]["window_mode"])
	var window_modes = [
		DisplayServer.WINDOW_MODE_WINDOWED,
		DisplayServer.WINDOW_MODE_FULLSCREEN,
		DisplayServer.WINDOW_MODE_WINDOWED,
		DisplayServer.WINDOW_MODE_FULLSCREEN
	]
	var borderless_flags = [false, false, true, true]
	
	if window_mode >= 0 and window_mode < window_modes.size():
		DisplayServer.window_set_mode(window_modes[window_mode])
		DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, borderless_flags[window_mode])
	#endregion
	
	#region VSync
	var vsync = config.get_value("display", "vsync", DEFAULT_SETTINGS["display"]["vsync"])
	DisplayServer.window_set_vsync_mode(vsync)
	#endregion

func apply_audio_settings():
	#region Master Volume
	var master_volume = config.get_value("audio", "master_volume", DEFAULT_SETTINGS["audio"]["master_volume"])
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), 20.0 * log(master_volume) / log(10.0))
	#endregion

func apply_general_settings():
	#region Language
	var language = config.get_value("general", "language", DEFAULT_SETTINGS["general"]["language"])
	TranslationServer.set_locale(language)
	#endregion

func set_setting(section: String, key: String, value):
	config.set_value(section, key, value)
	save_settings()
	apply_settings()
