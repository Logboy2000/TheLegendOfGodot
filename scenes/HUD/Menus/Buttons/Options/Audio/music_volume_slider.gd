extends MarginContainer

@onready var slider: HSlider = $HBoxContainer/Slider

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var saved_value = SettingsManager.get_setting("audio", "music")
	slider.value = saved_value


func _on_slider_value_changed(value: float) -> void:
	SettingsManager.set_setting("audio", "music", value)
