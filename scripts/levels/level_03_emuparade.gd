extends Node2D

@onready var player: Player = $Player
@onready var maggie: CharacterBody2D = $NPCs/Maggie
@onready var interact_icon: Sprite2D = $MaggieDoor/InteractIcon

var player_in_range = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _process(delta: float) -> void:
	player.visible = true
	if player_in_range and Input.is_action_just_pressed("action"):
		interact_icon.hide()
		doorknock()


func _on_maggie_door_body_entered(body: Node2D) -> void:
	interact_icon.show()
	if GameManager.maggie_endgame == true:
		endgame()
	else:
		#Trigger "she's not here" conversation
		#Maybe have a couple of these
			#maggie_not_home = true
				#trigger randoms, etc
		pass


func _on_maggie_door_body_exited(body: Node2D) -> void:
	interact_icon.hide()
	
func doorknock():
	pass

func endgame():
	pass
	#make maggie appear
	#then have talk icon appear
	#then trigger endgame
