extends Area2D

@onready var sprite: AnimatedSprite2D = $Sprite
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
const COLLECTED_ANIMATION = preload("res://scenes/Objects/Collectibles/collected_animation.tscn")
func _ready() -> void:
	sprite.play()

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		var collect_sprite = COLLECTED_ANIMATION.instantiate()
		collect_sprite.position = position
		add_sibling(collect_sprite)
		queue_free()
