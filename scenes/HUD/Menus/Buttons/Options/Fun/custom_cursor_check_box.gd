extends MarginContainer

@onready var check_box:= $HBoxContainer/CheckBox


func _ready():
	var setting = SettingsManager.get_setting("general", "custom_cursor")
	check_box.button_pressed = setting


func _on_check_box_pressed():
	SettingsManager.set_setting("general", "custom_cursor", check_box.button_pressed)
