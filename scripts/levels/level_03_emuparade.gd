extends Node2D

@onready var player: Player = $Player
@onready var maggie: CharacterBody2D = $Maggie

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	player.visible = true
	

func _on_demo_end_gate_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") and maggie.met_maggie == true:
		get_tree().change_scene_to_file("res://scenes/menus/demo_end.tscn")
