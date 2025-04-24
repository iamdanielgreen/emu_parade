extends Node2D

@onready var player: Player = $Player
@onready var cassie_animation: AnimatedSprite2D = $AnimatedSprite2D


func _process(delta: float) -> void:
	player.visible = true
	#change_scene()
	
func _on_playtest_end_gate_body_entered(body: Node2D) -> void:
	get_tree().change_scene_to_file("res://scenes/levels/level_03_emuparade.tscn")
