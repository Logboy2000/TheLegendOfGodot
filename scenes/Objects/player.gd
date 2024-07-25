extends CharacterBody2D

#Nodes
@onready var sprite = $AnimatedSprite2D

#Constants
const WALL_SLIDE_SPEED = 5.0
const JUMP_VELOCITY = 250.0
const COYOTE_TIME_FRAMES: int = 10

const MAX_WALK_SPEED = 240.0
const GROUNDED_ACCELERATION = 20.0
const GROUNDED_DECELERATION = 60.0

const AIR_ACCELERATION = 2.0
const AIR_DECELERATION = 1.0

const ICE_ACCELERATION = 5.0
const ICE_DECELERATION = 10.0

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
var gravity_scale = ProjectSettings.get_setting("physics/2d/default_gravity")
var state: States = States.DOUBLE_JUMPING
var direction: float
var air_time_frames: int = 3
var has_double_jump: bool = true
var can_jump: bool = false




func _physics_process(_delta):
	update_states()
	get_input()
	if is_on_floor():
		can_jump = true
		has_double_jump = true
	else:
		velocity.y += gravity_scale
	
	if direction != 0:
		if is_on_floor():
			velocity.x += GROUNDED_ACCELERATION * direction
		else:
			velocity.x += AIR_ACCELERATION * direction
	limit_speed()
	move_and_slide()
	update_debug()
	update_sprite()
func limit_speed():
	if is_on_floor() and abs(velocity.x) > MAX_WALK_SPEED:
		velocity.x = move_toward(velocity.x, 0, GROUNDED_DECELERATION)
	elif direction == 0:
		velocity.x = move_toward(velocity.x, 0, AIR_DECELERATION)
func jump():
	if can_jump:
		velocity.y = -JUMP_VELOCITY
	elif has_double_jump:
		velocity.y = -JUMP_VELOCITY
		has_double_jump = false
func get_input():
	direction = Input.get_axis("left", "right")
	if Input.is_action_just_pressed("jump"): jump()
func update_states():
	if is_on_floor():
		if velocity.x == 0 and direction == 0:
			state = States.IDLE
		if velocity.x != 0: 
			state = States.WALKING
			if Input.is_action_pressed("run"):
				state = States.RUNNING
	else:
		if velocity.y < 0:
			state = States.JUMPING
		else: 
			state = States.FALLING
		if has_double_jump == false:
			state = States.DOUBLE_JUMPING
func update_sprite():
	if velocity.x != 0 and is_on_floor():
		sprite.speed_scale = velocity.x / MAX_WALK_SPEED
		if sprite.speed_scale < 1: sprite.speed_scale = 1
	else:
		sprite.speed_scale = 1
	if direction > 0:
		sprite.flip_h = false
	if direction < 0:
		sprite.flip_h = true
	match state:
		States.IDLE:
			sprite.play("idle")
		States.JUMPING:
			sprite.play("jumping")
		States.WALKING:
			sprite.play("walking")
		States.RUNNING:
			sprite.play("walking")
		States.DOUBLE_JUMPING:
			sprite.play("double_jumping")
		States.FALLING:
			sprite.play("falling")
		States.DAMAGED:
			sprite.play("hit")
		States.WALL:
			sprite.play("wall")
func update_debug():
	if GameManager.debug_enabled:
		DebugMenu.display_position = round(position)
		DebugMenu.display_velocity = velocity
