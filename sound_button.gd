extends Button

@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer

func _on_pressed() -> void:
	audio_stream_player.play(0)
