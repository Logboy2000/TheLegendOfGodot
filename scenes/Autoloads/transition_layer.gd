extends CanvasLayer

@onready var animation_player = $AnimationPlayer
var screen_transition: String

func change_scene(target: String, transition: String = screen_transition) -> void:
	animation_player.play(transition)
	await animation_player.animation_finished
	get_tree().change_scene_to_file(target)
	get_tree().paused = false
	animation_player.play_backwards(transition)

func fade_to_black():
	animation_player.play(screen_transition)
	await animation_player.animation_finished
