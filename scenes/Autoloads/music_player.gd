extends AudioStreamPlayer

func _ready() -> void:
	await SettingsManager.settings_applied
	play(0)
