extends Node
var pause_frames
@export var debug_enabled: bool = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	if Input.is_action_just_pressed("debugmenu"):
		debug_enabled = !debug_enabled
	if Input.is_action_just_pressed("reload_room"):
		get_tree().reload_current_scene()
	if Input.is_action_just_pressed("fullscreen"):
		var setting_value: int = 0
		match SettingsManager.get_setting("display", "window_mode"):
			0: setting_value = 1
			1: setting_value = 0
			2: setting_value = 3
			3: setting_value = 2
		SettingsManager.set_setting("display", "window_mode", setting_value)
	
