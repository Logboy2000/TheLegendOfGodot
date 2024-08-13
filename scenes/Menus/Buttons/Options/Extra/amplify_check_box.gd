extends MarginContainer

@onready var check_box:= $HBoxContainer/CheckBox


func _ready():
	var setting = SettingsManager.get_setting("stupid", "amplify_audio")
	check_box.button_pressed = setting


func _on_check_box_pressed():
	SettingsManager.set_setting("stupid", "amplify_audio", check_box.button_pressed)
