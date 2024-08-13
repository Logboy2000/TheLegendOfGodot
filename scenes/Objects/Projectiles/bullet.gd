extends RigidBody2D
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer
@onready var collision_shape: CollisionShape2D = $CollisionShape2D
@onready var area_shape: CollisionShape2D = $Area2D/CollisionShape2D
@onready var sprite: Sprite2D = $Sprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var timer: Timer = $Timer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer.start(randf_range(4.0,5.0))
	audio_stream_player.play(0)

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("spring"):
		linear_velocity.y = -400


func _on_timer_timeout() -> void:
	animation_player.play("fade_out")
	collision_shape.disabled = true
	area_shape.disabled = true



func _on_animation_player_animation_finished(_anim_name: StringName) -> void:
	queue_free()
