extends Node2D

@export_file("*.tscn") var destination_scene

func _on_area_2d_body_entered(body: Node2D) -> void:
	body.save_player_state()
	TransitionLayer.change_scene(destination_scene)
