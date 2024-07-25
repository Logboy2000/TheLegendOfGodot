extends Node
@export var debug_enabled: bool = false
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	if Input.is_action_just_pressed("debugmenu"):
		debug_enabled = !debug_enabled
	if Input.is_action_just_pressed("reload_room"):
		get_tree().reload_current_scene()
