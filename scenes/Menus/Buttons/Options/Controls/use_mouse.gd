extends MarginContainer

@onready var check_box: CheckBox = $HBoxContainer/CheckBox

func _ready():
	var setting = SettingsManager.get_setting("controls", "mouse_aim")
	check_box.button_pressed = setting

func _on_check_box_toggled(toggled_on: bool) -> void:
	SettingsManager.set_setting("controls", "mouse_aim", toggled_on)
