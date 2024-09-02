extends Node
var pause_frames
var force_camera_center: bool = false
@export var debug_enabled: bool = true
var input_direction: Vector2

func _physics_process(_delta):
	input_direction = Vector2(Input.get_axis("left", "right"), Input.get_axis("down", "up")) 
	
	
	if Input.is_action_just_pressed("fullscreen"):
		var setting_value: int = 0
		match SettingsManager.get_setting("display", "window_mode"):
			0: setting_value = 1
			1: setting_value = 0
			2: setting_value = 3
			3: setting_value = 2
		SettingsManager.set_setting("display", "window_mode", setting_value)
