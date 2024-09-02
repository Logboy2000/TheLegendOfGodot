@tool
extends CharacterBody2D
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
@onready var sprite = $AnimatedSprite2D
@onready var collision_shape = $CollisionPolygon2D
@onready var gun: Node2D = $Gun

const DASH_TRAIL = preload("res://scenes/Objects/Particles/dash_trail.tscn")

signal dash_ended

@export_category("General")
@export var state: States
@export var facing_direction: float = 1
@export_enum("Default") var skin = "Default"

@export_category("Movement")
@export var gravity: float = 16.0
@export var gravity_scale: float = 1.0
@export var max_run_speed: float = 90.0
@export var run_acceleration := 1000.0
@export var run_reduce := 400
@export var air_speed_multiplier := 0.75
var use_mouse_aiming := false
var move_speed_multiplier := 1



@export_category("Jump")

@export var jump_speed = 300
@export var coyote_time_frames: int
@export var jump_buffer_frames: int


@export_category("Dash")

@export var dash_speed = 1000
@export var dash_length_frames: int
@export var dash_delay_frames: int

var frames_since_grounded: int = 100
var frames_since_jumped: int = 100
var dash_frames: int = 0
var input_direction: Vector2
var dash_direction: float

var can_jump: bool = false
var can_dash: bool = true

var is_jumping: bool = false
var is_dashing: bool = false

func _enter_tree() -> void:
	load_player_state()

func _physics_process(delta):
	input_direction = GameManager.input_direction
	if input_direction.x != 0:
		facing_direction = input_direction.x
	
	#region Run
	if (abs(velocity.x) > max_run_speed and sign(velocity.x) == input_direction.x) and not is_dashing:
		#Reduce back from beyond the max speed
		velocity.x = move_toward(velocity.x, max_run_speed * input_direction.x, run_reduce * move_speed_multiplier * delta)
	else:
		#Approach the max speed
		velocity.x = move_toward(velocity.x, max_run_speed * input_direction.x, run_acceleration * move_speed_multiplier * delta)  

	#endregion
	#region Jump
	if is_on_floor():
		can_jump = true 
		can_dash = true
		is_jumping = false
		frames_since_grounded = 0
	else:
		frames_since_grounded += 1
	if Input.is_action_just_pressed("jump"):
		frames_since_jumped = 0
	else:
		frames_since_jumped += 1
	if frames_since_grounded < coyote_time_frames and frames_since_jumped < jump_buffer_frames and can_jump:
		can_jump = false
		is_dashing = false
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
	#endregion
	#region Dash
	if Input.is_action_just_pressed("dash") and can_dash:
		var dash_trail = DASH_TRAIL.instantiate()
		add_child(dash_trail)
		dash_direction = facing_direction
		is_dashing = true
		can_dash = false
		dash_frames = 0
		
	if is_dashing:
		velocity.x = dash_speed * dash_direction
		dash_frames += 1
		velocity.y = 0
		if dash_frames > dash_length_frames: #on dash end
			is_dashing = false
			
			dash_ended.emit()
	
	#endregion
	#region Gun

		
	if Input.is_action_just_pressed("attack"):
		gun.shoot()
		velocity -= gun.shoot_direction * gun.recoil
	
	
	
	#endregion
	
	if not is_dashing:
		velocity.y += gravity * gravity_scale
	move_and_slide()
	update_states()
	update_sprite()
	update_debug()

	
func update_states():
	if is_on_floor():
		if velocity.x == 0 and input_direction.x == 0:
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
		#sprite.speed_scale = abs(velocity.x / max_speed.x)
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



func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("spring"):
		velocity.y = -400
		can_jump = false 
		can_dash = true
		is_jumping = false
		frames_since_grounded = 0
		is_dashing = false

func save_player_state():
	PlayerState.velocity = velocity
	PlayerState.facing_direction = facing_direction
func load_player_state():
	velocity = PlayerState.velocity
	facing_direction = PlayerState.facing_direction


func _on_dash_ended() -> void:
	pass
