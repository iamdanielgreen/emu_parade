extends Node2D

@onready var player: Player = $Player
@onready var maggie_endgame: CharacterBody2D = $NPCs/Maggie_Endgame
@onready var maggie_door_icon: Sprite2D = $MaggieDoor/InteractIcon
@onready var grow_garden_icon: Sprite2D = $GardenGrowZone/InteractIcon

var player_in_range = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _process(delta: float) -> void:
	player.visible = true
	if player_in_range and Input.is_action_just_pressed("action"):
		maggie_door_icon.hide()
		doorknock()
				


func _on_maggie_door_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		maggie_door_icon.show()
		player_in_range = true

func _on_maggie_door_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		maggie_door_icon.hide()
		player_in_range = false
	
		#Trigger "she's not here" conversation
		#Maybe have a couple of these
			#maggie_not_home = true
				#trigger randoms, etc
		
func doorknock():
	if GameManager.met_cookie == true:
		maggie_endgame.show()
		
	else:
		return
		#TODO: Start dialogue saying maggie's not home
		
#func endgame():
	#print("ROLL CREDITS")


func _on_garden_grow_zone_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		if GameManager.grow_garden == true:
			print("ROLL CREDITS")
			get_tree().change_scene_to_file("res://scenes/menus/credits.tscn")

func _on_garden_grow_zone_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		grow_garden_icon.hide()
