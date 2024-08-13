extends Node2D
@onready var sprite: Sprite2D = $Sprite2D

const BULLET = preload("res://scenes/Objects/Projectiles/bullet.tscn")
@onready var bullet_spawn_position: Node2D = $Sprite2D/BulletSpawn
@export var bullet_speed: float = 500
@export var bullet_count: int = 1
func shoot(bullet_direction: Vector2):
	for i in bullet_count:
		var bullet = BULLET.instantiate()
		bullet.linear_velocity = bullet_direction * bullet_speed
		bullet.rotation_degrees = rad_to_deg(bullet.linear_velocity.angle())
		bullet.position = bullet_spawn_position.global_position
		get_tree().current_scene.add_node(bullet)
