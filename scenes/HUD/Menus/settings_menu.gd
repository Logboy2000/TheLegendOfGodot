extends Control

func _on_back_pressed():
	if get_tree().paused:
		visible = false
	else:
		TransitionLayer.change_scene("res://scenes/HUD/Menus/title_menu.tscn")


func _on_reset_pressed():
	SettingsManager.load_defaults()
