extends Node2D

@export_file("*.tscn") var destination_scene

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		TransitionLayer.change_scene(destination_scene)
