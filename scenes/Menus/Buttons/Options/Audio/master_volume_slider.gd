extends MarginContainer

@onready var slider: HSlider = $HBoxContainer/Slider

func _ready() -> void:
	var saved_value = SettingsManager.get_setting("audio", "master")
	slider.value = saved_value

func _on_slider_value_changed(value: float) -> void:
	SettingsManager.set_setting("audio", "master", value)
