extends CharacterBody2D

#Nodes
@onready var sprite = $AnimatedSprite2D
@onready var collision_shape = $CollisionPolygon2D

enum States {
	IDLE,
	WALKING,
	RUNNING,
	JUMPING,
	DOUBLE_JUMPING,
	FALLING,
	DAMAGED,
	WALL,
}

#Variables

@export var jump_speed = 300
@export var dash_speed = 1000
var state: States

var max_speed: Vector2 = Vector2(120,400)
@export var normal_max_speed: Vector2 = Vector2(120,400)

@export var coyote_time_frames: int
@export var jump_buffer_frames: int
@export var dash_length_frames: int
@export var dash_delay_frames: int

var frames_since_grounded: int = 3
var frames_since_jumped: int = 3
var dash_frames: int = 0

var input_direction: float
var facing_direction: float = 1
var dash_direction: int
@export var gravity: float = 16.0
var gravity_scale: float = 1



var can_jump: bool = false
var can_dash: bool = true

var is_jumping: bool = false
var is_dashing: bool = false


func _physics_process(_delta):
	input_direction = Input.get_axis("left", "right")
	if input_direction != 0:
		facing_direction = input_direction
	#region Run
	if input_direction != 0:
		velocity.x = input_direction * max_speed.x
	else:
		velocity.x = 0
	#endregion
	#region Jump
	if is_on_floor():
		floor_touched()
	else:
		frames_since_grounded += 1
	if Input.is_action_just_pressed("jump"):
		frames_since_jumped = 0
	else:
		frames_since_jumped += 1
	if frames_since_grounded < coyote_time_frames and frames_since_jumped < jump_buffer_frames and can_jump:
		can_jump = false
		velocity.y = -jump_speed
		if Input.is_action_pressed("jump"):
			is_jumping = true
	if Input.is_action_just_released("jump") and is_jumping and velocity.y < 0:
		is_jumping = false
		velocity.y *= 0.25
	if velocity.y < 0:
		gravity_scale = 0.5
	else:
		gravity_scale = 1
	#endregion
	#region Limit Speed
	if velocity.x > max_speed.x:
		velocity.x = lerp(velocity.x, max_speed.x, 1)
	if velocity.y > max_speed.y:
		velocity.y = lerp(velocity.y, max_speed.y, 1)
	#endregion
	#region Dash
	if Input.is_action_just_pressed("dash") and can_dash:
		is_dashing = true
		can_dash = false
		
		dash_frames = 0
	if is_dashing:
		velocity.x = dash_speed * facing_direction
		dash_frames += 1
		velocity.y = 0
		if dash_frames > dash_length_frames:
			is_dashing = false
	
#endregion
	
	
	if not is_dashing:
		velocity.y += gravity * gravity_scale
	move_and_slide()
	update_states()
	update_sprite()
	update_debug()



func update_states():
	if is_on_floor():
		if velocity.x == 0 and input_direction == 0:
			state = States.IDLE
		if velocity.x != 0: 
			state = States.WALKING
	else:
		if velocity.y < 0:
			state = States.JUMPING
		else: 
			state = States.FALLING
func update_sprite():
	if velocity.x != 0 and is_on_floor():
		sprite.speed_scale = abs(velocity.x / max_speed.x)
		if sprite.speed_scale < 1: sprite.speed_scale = 1
	else:
		sprite.speed_scale = 1
	if facing_direction > 0:
		sprite.flip_h = false
	if facing_direction < 0:
		sprite.flip_h = true
	match state:
		States.IDLE:
			sprite.play("idle")
		States.JUMPING:
			sprite.play("jump")
		States.WALKING:
			sprite.play("run")
		States.RUNNING:
			sprite.play("run")
		States.DOUBLE_JUMPING:
			sprite.play("double_jumping")
		States.FALLING:
			sprite.play("fall")
		States.DAMAGED:
			sprite.play("hit")
		States.WALL:
			sprite.play("wall")
func update_debug():
	DebugMenu.display_position = round(position)
	DebugMenu.display_velocity = velocity
func floor_touched():
	can_jump = true 
	can_dash = true
	is_jumping = false
	frames_since_grounded = 0


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("spring"):
		floor_touched()
		is_dashing = false
		velocity = Vector2(0,-400) 
