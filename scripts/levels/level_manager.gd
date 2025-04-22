extends Node2D




func _on_level_gate_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		get_tree().change_scene_to_file("res://scenes/levels/world.tscn")
