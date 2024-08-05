extends Control

@onready var are_you_sure: Panel = $AreYouSure
@onready var tab_container: TabContainer = $MarginContainer/VBoxContainer/TabContainer
@onready var transition_change_button: MarginContainer = $MarginContainer/VBoxContainer/TabContainer/General/VBoxContainer/TransitionChangeButton

func _physics_process(_delta: float) -> void:
	if Input.is_key_pressed(KEY_1):
		tab_container.current_tab = 0
	elif Input.is_key_pressed(KEY_2):
		tab_container.current_tab = 1
	elif Input.is_key_pressed(KEY_3):
		tab_container.current_tab = 2
	elif Input.is_key_pressed(KEY_4):
		tab_container.current_tab = 3
	elif Input.is_key_pressed(KEY_5):
		tab_container.current_tab = 4
	if Input.is_action_just_pressed("next_tab"):
		tab_container.select_next_available()
	if Input.is_action_just_pressed("prev_tab"):
		tab_container.select_previous_available()


func _on_back_pressed():
	leave_menu()

func _on_reset_pressed():
	are_you_sure.visible = true

func leave_menu():
	if get_tree().paused:
		are_you_sure.visible = false
		visible = false
	else:
		await TransitionLayer.change_scene("res://scenes/HUD/Menus/title_menu.tscn")


func _on_cancel_pressed() -> void:
	are_you_sure.visible = false

func _on_yes_pressed() -> void:
	await leave_menu()
	SettingsManager.load_defaults()


func _on_visibility_changed() -> void:
	transition_change_button.grab_focus()
