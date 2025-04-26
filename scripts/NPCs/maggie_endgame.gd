extends CharacterBody2D

@onready var maggie_animation: AnimatedSprite2D = $AnimatedSprite2D
@onready var player: Player = $"../../Player"
@onready var maggie: CharacterBody2D = $"../Maggie"

@onready var talk_icon: Sprite2D = $TalkIcon

var player_in_range = false
var visit_maggie = false

func _process(delta):
	if player_in_range and Input.is_action_pressed("action"):
		if Dialogic.current_timeline == null:
			if visit_maggie == false:
				talk_icon.hide()
				Dialogic.start("07_01_Maggie_GameEnd")
				visit_maggie = true
				GameManager.grow_garden = true
			#NOTE: YOU ADD THE GAMEMANAGER CONDITION LATER. IF YOU CHANGE IT NOW, IT COULD ALLOW FOR SEQUENCE BREAKS.
		else:
			if Dialogic.current_timeline == null:
				if GameManager.met_cookie == true:
					next_step()
				else:
					random_maggie()


func _physics_process(delta: float) -> void:
	maggie_animation.play("Idle")
	
func random_maggie(): #Tutorial calls this "run_rando_dialogue"
	Dialogic.timeline_ended.connect(dialogue_end) #Tutorial says "ended_dialogue" instead.
	talk_icon.hide()
	var dialogue_line = randi_range(0,3) 
	Dialogic.start("07_maggie_random_" + str(dialogue_line))

func dialogue_end():
	Dialogic.timeline_ended.disconnect(dialogue_end)


func _on_interact_zone_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_in_range = true
		talk_icon.show()

func _on_interact_zone_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_in_range = false
		talk_icon.hide()
		
		
func next_step():
	talk_icon.hide()
	#Dialogic.start("07_02_Maggie_gardentips")
	GameManager.grow_garden = true
	
