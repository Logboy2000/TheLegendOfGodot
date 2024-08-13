extends Node
var settings_path = "user://settings.ini"
var config = ConfigFile.new()
const CURSOR = preload("res://assets/Sprites/Cursor.png")

signal settings_applied

# Define default values
const DEFAULT_SETTINGS = {
	"general": {
		"language": "en", 
		"custom_cursor": true,
		"screen_transition": 0
	},
	"display": {
		"window_mode": 0, 
		"vsync": 0
	},
	"audio": {
		"master": 0.5,
		"music": 0.5,
		"sfx": 0.5
	},
	"stupid": {
		"amplify_audio": false
	}
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
	apply_fun_settings()
	settings_applied.emit()

func apply_display_settings():
	#region Window Mode
	var window_mode = get_setting("display", "window_mode")
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
	var vsync = get_setting("display", "vsync")
	DisplayServer.window_set_vsync_mode(vsync)
	#endregion

func apply_audio_settings():
	var master = get_setting("audio", "master")
	var music = get_setting("audio", "music")
	var sfx = get_setting("audio", "sfx")
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), linear_to_db(master))
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), linear_to_db(music))
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), linear_to_db(sfx))

func apply_general_settings():
	var screen_transition: int = get_setting("general", "screen_transition")
	TransitionLayer.screen_transition = TransitionLayer.animation_player.get_animation_list()[screen_transition]
	
	var use_custom_cursor = get_setting("general", "custom_cursor")
	if use_custom_cursor:
		Input.set_custom_mouse_cursor(CURSOR)
	else:
		Input.set_custom_mouse_cursor(null)
	
	var language = get_setting("general", "language")
	TranslationServer.set_locale(language)

func apply_fun_settings():
	var amplify_audio = get_setting("stupid", "amplify_audio")
	AudioServer.set_bus_effect_enabled(0, 0, amplify_audio)

func get_setting(section: String, key: String):
	return config.get_value(section, key, DEFAULT_SETTINGS[section][key])

func set_setting(section: String, key: String, value):
	config.set_value(section, key, value)
	save_settings()
	apply_settings()
	
