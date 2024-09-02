extends Node2D
@onready var sprite: Sprite2D = $Sprite2D

const BULLET = preload("res://scenes/Objects/Projectiles/bullet.tscn") # bullet is rigidbody 2d
@onready var bullet_spawn: Node2D = $BulletSpawnOrigin/BulletSpawn
@onready var bullet_spawn_origin: Node2D = $BulletSpawnOrigin
@export var bullet_speed: float = 500
@export var bullet_count: int = 1
@export var recoil: float = 500

var shoot_direction: Vector2 = Vector2(1,0)
var input_direction: Vector2
var facing_direction: int = 1

func _physics_process(_delta: float) -> void:
	input_direction = GameManager.input_direction
	input_direction.y *= -1
	if shoot_direction.x < 0:
		sprite.flip_v = true
	elif shoot_direction.x > 0:
		sprite.flip_v = false
	if SettingsManager.mouse_aim == true:
		handle_mouse_aim()
	else:
		handle_keyboard_aim()

func handle_keyboard_aim():
	if input_direction != Vector2.ZERO:
		shoot_direction = input_direction.normalized()
	if input_direction.y == 0:
		shoot_direction.y = 0
	bullet_spawn_origin.rotation = shoot_direction.angle()
	sprite.rotation = lerp(sprite.rotation, shoot_direction.angle(), 0.25)
	
func handle_mouse_aim():
	bullet_spawn_origin.look_at(get_global_mouse_position())
	sprite.look_at(get_global_mouse_position())
	shoot_direction = bullet_spawn.global_position.direction_to(get_global_mouse_position())


func shoot():
	for i in bullet_count:
		var bullet = BULLET.instantiate() as RigidBody2D
		bullet.linear_velocity = shoot_direction * bullet_speed
		bullet.rotation_degrees = rad_to_deg(bullet.linear_velocity.angle())
		bullet.position = bullet_spawn.global_position
		get_tree().current_scene.add_child(bullet)
