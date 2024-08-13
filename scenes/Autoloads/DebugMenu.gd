extends CanvasLayer
#Left Menu
@onready var info_hud = $MarginContainer/InfoHUD

@onready var game_version = $MarginContainer/InfoHUD/GameVersion
@onready var fps = $MarginContainer/InfoHUD/FPS
var max_fps
@onready var room: Label = $MarginContainer/InfoHUD/Room
@onready var position = $MarginContainer/InfoHUD/Position
@onready var velocity = $MarginContainer/InfoHUD/Velocity
var display_position: Vector2 = Vector2(0,0)
var display_velocity: Vector2 = Vector2(0,0)


func _ready():
	game_version.text = ProjectSettings.get_setting("application/config/name")+" (v"+ProjectSettings.get_setting("application/config/version")+")"
func _physics_process(_delta):
	if Input.is_action_just_pressed("debugmenu"):
		visible = !visible


func _on_update_speed_timeout():
	if Input.is_action_just_pressed("reload_room"):
		await TransitionLayer.play_transition(false)
		get_tree().reload_current_scene()
		TransitionLayer.play_transition(true)
	if visible:
		debug_menu()

func debug_menu():
	if DisplayServer.window_get_vsync_mode() != DisplayServer.VSYNC_DISABLED:
		max_fps = str(round(DisplayServer.screen_get_refresh_rate()))+" (VSync Mode: "+str(DisplayServer.window_get_vsync_mode())+")"
	else:
		max_fps = "Unlimited"
	fps.text =  "FPS: "+str(Engine.get_frames_per_second())+"/"+max_fps
	room.text = "Room: "+get_tree().current_scene.name
	position.text = "X: "+str(display_position.x)+"  Y: "+str(display_position.y)
	velocity.text = "Xv: "+str(display_velocity.x)+"  Yv: "+str(display_velocity.y)
