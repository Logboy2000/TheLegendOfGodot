extends CanvasLayer

@onready var animation_player = $AnimationPlayer
var screen_transition: String
var is_transitioning: bool = false

func change_scene(target: String, transition: String = screen_transition) -> void:
	get_tree().paused = true
	is_transitioning = true
	animation_player.play(transition)
	await animation_player.animation_finished
	get_tree().change_scene_to_file(target)
	is_transitioning = false
	animation_player.play_backwards(transition)
	await animation_player.animation_finished
	get_tree().paused = false

func play_transition(reverse: bool = false):
	if reverse:
		animation_player.play_backwards(screen_transition)
	else:
		animation_player.play(screen_transition)
	await animation_player.animation_finished
