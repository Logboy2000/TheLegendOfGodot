extends Control

@onready var play: Button = $VBoxContainer/Play

func _ready() -> void:
	play.grab_focus()

func _on_play_pressed():
	TransitionLayer.change_scene("res://scenes/Rooms/Start/0.tscn")

func _on_options_pressed():
	TransitionLayer.change_scene("res://scenes/Rooms/Menus/settings.tscn")

func _on_exit_pressed():
	await TransitionLayer.play_transition()
	get_tree().quit()
