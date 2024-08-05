extends Camera2D


var limits_enabled: bool = true
var prev_left_limit = limit_left
var prev_top_limit = limit_top
var prev_right_limit = limit_right
var prev_bottom_limit = limit_bottom

func _physics_process(_delta: float) -> void:
	if GameManager.debug_enabled:
		if Input.is_action_just_pressed("zoom_in"):
			zoom *= 1.1
		if Input.is_action_just_pressed("zoom_out"):
			zoom /= 1.1
		if Input.is_action_pressed("rotate_clockwise"):
			rotation_degrees += 2
		if Input.is_action_pressed("rotate_counterclockwise"):
			rotation_degrees -= 2
		if Input.is_action_just_pressed("disable_camera_limit"):
			if limits_enabled:
				prev_left_limit = limit_left
				prev_top_limit = limit_top
				prev_right_limit = limit_right
				prev_bottom_limit = limit_bottom
				limit_left = -1000000000
				limit_top = -1000000000
				limit_right = 1000000000
				limit_bottom = 1000000000
			else:
				limit_left = prev_left_limit
				limit_top = prev_top_limit
				limit_right = prev_right_limit
				limit_bottom = prev_bottom_limit
			limits_enabled = !limits_enabled
			position_smoothing_enabled = limits_enabled
