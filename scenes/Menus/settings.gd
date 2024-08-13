extends Control
@onready var reset: Button = $MarginContainer/VBoxContainer/HBoxContainer/Reset
@onready var cancel: Button = $AreYouSure/VBoxContainer/HBoxContainer/Cancel
@onready var are_you_sure: Panel = $AreYouSure
@onready var tab_container: TabContainer = $MarginContainer/VBoxContainer/TabContainer
@onready var transition_dropdown: MarginContainer = $MarginContainer/VBoxContainer/TabContainer/General/VBoxContainer/TransitionDropdown

func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel") and visible:
		_on_back_pressed()
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
	cancel.grab_focus()

func leave_menu():
	if get_tree().paused:
		are_you_sure.visible = false
		visible = false
	else:
		TransitionLayer.change_scene("res://scenes/Rooms/Menus/title.tscn")


func _on_cancel_pressed() -> void:
	are_you_sure.visible = false
	reset.grab_focus()

func _on_yes_pressed() -> void:
	await leave_menu()
	SettingsManager.load_defaults()


func _on_focus_entered() -> void:
	transition_dropdown.grab_focus()
