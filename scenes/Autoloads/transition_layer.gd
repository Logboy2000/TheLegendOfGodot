extends CanvasLayer

@onready var animation_player = $AnimationPlayer
@export_enum(
	"fade_to_black", 
	"slide_from_sides", 
	"slide_from_top", 
	"spinning_charlie",
	"hard_cut",
	"circle",
) 
var screen_transition: String = "fade_to_black"
func change_scene(target: String) -> void:
	animation_player.play(screen_transition)
	await animation_player.animation_finished
	get_tree().change_scene_to_file(target)
	get_tree().paused = false
	animation_player.play_backwards(screen_transition)

func fade_to_black():
	animation_player.play(screen_transition)
	await animation_player.animation_finished
