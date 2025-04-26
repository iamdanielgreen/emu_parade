#NOTE: LOUISE PRESENTLY HAS NO CONDITIONALS.

extends CharacterBody2D

@onready var louise_animation: AnimatedSprite2D = $AnimatedSprite2D
@onready var player: Player = $"../../Player"

@onready var talk_icon: Sprite2D = $TalkIcon

var player_in_range = false
var met_louise = false

func _process(delta):
	if player_in_range and Input.is_action_pressed("action"):
		if Dialogic.current_timeline == null and !met_louise:
			talk_icon.hide()
			Dialogic.start("03_02_03_meet_louise")
			met_louise = true
			#NOTE: YOU ADD THE GAMEMANAGER CONDITION LATER. IF YOU CHANGE IT NOW, IT COULD ALLOW FOR SEQUENCE BREAKS.
		else:
			if Dialogic.current_timeline == null:
				if GameManager.met_louise == true:
					Dialogic.start("03_02_03_louise_business")
					#next_step()
				else:
					return
					#random_louise()


func _physics_process(delta: float) -> void:
	louise_animation.play("Idle")

#NOTE: NOT CURRENTLY ACTIVE
func random_louise(): #Tutorial calls this "run_rando_dialogue"
	Dialogic.timeline_ended.connect(dialogue_end) #Tutorial says "ended_dialogue" instead.
	talk_icon.hide()
	var dialogue_line = randi_range(0,3) 
	Dialogic.start("03_05_louise_random_" + str(dialogue_line))

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
		
		
#func next_step():
	#talk_icon.hide()
	#Dialogic.start("03_05_02_wren_nextstep")
	#GameManager.met_robin = true
	
