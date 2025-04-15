extends Node2D

@onready var player: Player = $"../Player"


var player_in_bin_range = false

func _on_area_2d_body_entered(body: Node2D) -> void:
	player_in_bin_range = true
		


func _on_area_2d_body_exited(body: Node2D) -> void:
	player_in_bin_range = false
