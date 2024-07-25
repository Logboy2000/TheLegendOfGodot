extends Control

func _on_play_pressed():
	TransitionLayer.change_scene("res://scenes/game.tscn")

func _on_options_pressed():
	TransitionLayer.change_scene("res://scenes/HUD/Menus/settings_menu.tscn")

func _on_exit_pressed():
	await TransitionLayer.fade_to_black()
	get_tree().quit()
