extends CanvasLayer
#Left Menu
@onready var info_hud = $MarginContainer/InfoHUD

@onready var game_version = $MarginContainer/InfoHUD/GameVersion
@onready var fps = $MarginContainer/InfoHUD/FPS
var max_fps
@onready var position = $MarginContainer/InfoHUD/Position
@onready var velocity = $MarginContainer/InfoHUD/Velocity
var display_position: Vector2 = Vector2(0,0)
var display_velocity: Vector2 = Vector2(0,0)


func _ready():
	game_version.text = "The Legend of Charlie (v"+ProjectSettings.get_setting("application/config/version")+" / Godot)"
func _physics_process(_delta):
	visible = GameManager.debug_enabled


func _on_update_speed_timeout():
	if GameManager.debug_enabled:
		if DisplayServer.window_get_vsync_mode() != DisplayServer.VSYNC_DISABLED:
			max_fps = str(round(DisplayServer.screen_get_refresh_rate()))+" (VSync Mode: "+str(DisplayServer.window_get_vsync_mode())+")"
		else:
			max_fps = "Unlimited"
		fps.text =  "FPS: "+str(Engine.get_frames_per_second())+"/"+max_fps
		
		position.text = "X: "+str(display_position.x)+"  Y: "+str(display_position.y)
		velocity.text = "Xv: "+str(display_velocity.x)+"  Yv: "+str(display_velocity.y)
