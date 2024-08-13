extends Camera2D


var prev_left_limit = limit_left
var prev_top_limit = limit_top
var prev_right_limit = limit_right
var prev_bottom_limit = limit_bottom


func _physics_process(_delta: float) -> void:
	if GameManager.debug_enabled:
		if Input.is_action_pressed("zoom_in"):
			zoom = zoom * 1.01
		if Input.is_action_pressed("zoom_out"):
			if zoom.x > 1.0:
				zoom /= 1.01
		if Input.is_action_pressed("rotate_clockwise"):
			rotation_degrees += 2
		if Input.is_action_pressed("rotate_counterclockwise"):
			rotation_degrees -= 2
