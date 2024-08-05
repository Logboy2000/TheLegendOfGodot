extends Node2D
@onready var animated_sprite = $AnimatedSprite2D


func _on_animated_sprite_2d_animation_finished():
	animated_sprite.play("idle")


func _on_spring_area_area_entered(_area: Area2D) -> void:
	animated_sprite.frame = 0
	animated_sprite.play("boing")
