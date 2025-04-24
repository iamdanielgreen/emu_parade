extends Node2D

@onready var player: Player = $Player

func _ready() -> void:
	player.awake = false
	Dialogic.start("01_01_PhoneAlarm")
		
	if GameManager.game_loadin == true:
		player.position.x = GameManager.player_awake_bedroom_posx
		player.position.y = GameManager.player_awake_bedroom_posy
	else:
		player.position.x = GameManager.player_exit_bedroom_posx
		player.position.y = GameManager.player_exit_bedroom_posy

func _process(delta: float) -> void:
	change_scene()
	if player.paused == true:
		player.visible = false

func _on_bedroom_level_gate_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		GameManager.transition_scene = true
		

func _on_bedroom_level_gate_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		GameManager.transition_scene = false

func change_scene():
	if GameManager.transition_scene == true:
		if GameManager.current_scene == "level_01_bedroom":
			get_tree().change_scene_to_file("res://scenes/levels/level_02_livingroom.tscn") #TODO: JUST A TEST
			GameManager.game_loadin = false
			#get_tree().change_scene_to_file("res://scenes/levels/level_02_livingroom.tscn")
			GameManager.transition_scene_end()
