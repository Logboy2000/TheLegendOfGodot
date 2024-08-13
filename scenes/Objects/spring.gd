extends Node2D
@onready var animated_sprite = $AnimatedSprite2D
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D
@export var launch_velocity: Vector2 = Vector2(0,-400) 

func _on_animated_sprite_2d_animation_finished():
	animated_sprite.play("idle")


func _on_spring_area_area_entered(_area: Area2D) -> void:
	animated_sprite.frame = 0
	audio_stream_player_2d.play(0)
	animated_sprite.play("boing")
