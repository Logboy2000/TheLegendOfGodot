extends Control

@onready var option_button = $HBoxContainer/OptionButton as OptionButton
@onready var transition_layer = TransitionLayer


func _ready():
	var TRANSITION_ARRAY : PackedStringArray = transition_layer.animation_player.get_animation_list()
	option_button.clear()
	for transition in TRANSITION_ARRAY:
		option_button.add_item(transition)
	
	var screen_transition = SettingsManager.get_setting("general", "screen_transition")
	option_button.selected = screen_transition
	


func _on_option_button_item_selected(index):
	SettingsManager.set_setting("general","screen_transition", index)
