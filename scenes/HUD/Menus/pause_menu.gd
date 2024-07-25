extends Control

@onready var settings_menu = $SettingsMenu

func _physics_process(_delta):
	if Input.is_action_just_pressed("pause"):
		toggle_paused()
func _on_resume_pressed():
	toggle_paused()

func toggle_paused():
	get_tree().paused = !get_tree().paused
	visible = get_tree().paused


func _on_back_to_title_pressed():
	TransitionLayer.change_scene("res://scenes/HUD/Menus/title_menu.tscn")





func _on_settings_pressed():
	settings_menu.visible = true
