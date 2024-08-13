extends CanvasLayer

var paused: bool = false
@onready var settings_menu: Control = $SettingsMenu

func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed("pause") and settings_menu.visible == false:
		toggle_pause()


func _on_resume_pressed() -> void:
	toggle_pause()


func toggle_pause():
	paused = !paused
	visible = paused
	get_tree().paused = visible
	


func _on_return_pressed() -> void:
	TransitionLayer.change_scene("res://scenes/Rooms/Menus/title.tscn")


func _on_options_pressed() -> void:
	settings_menu.visible = true
