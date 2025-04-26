#NOTE: PREVIOUS CHARACTER WAS MAGGIE

extends CharacterBody2D

@onready var robin_animation: AnimatedSprite2D = $AnimatedSprite2D
@onready var player: Player = $"../../Player"
@onready var maggie: CharacterBody2D = $"../Maggie"
@onready var talk_icon: Sprite2D = $TalkIcon

var player_in_range = false
var met_robin = false

func _process(delta):
	if player_in_range and Input.is_action_pressed("action"):
		if GameManager.met_maggie == true:
			maggie.hide()
			
		if Dialogic.current_timeline == null and !met_robin:
			talk_icon.hide()
			Dialogic.start("03_04_01_meet_robin")
			met_robin = true
			GameManager.met_robin = true
			#NOTE: YOU ADD THE GAMEMANAGER CONDITION LATER. IF YOU CHANGE IT NOW, IT COULD ALLOW FOR SEQUENCE BREAKS.
		else:
			return
			#random_robin()
			
			#if Dialogic.current_timeline == null:
				#if GameManager.helped_robin == true:
					#next_step()
				#else:
					#random_robin()


func _physics_process(delta: float) -> void:
	robin_animation.play("Idle")
	
func random_robin(): #Tutorial calls this "run_rando_dialogue"
	Dialogic.timeline_ended.connect(dialogue_end) #Tutorial says "ended_dialogue" instead.
	talk_icon.hide()
	var dialogue_line = randi_range(0,3) 
	Dialogic.start("03_04_robin_random_" + str(dialogue_line))

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
	#Dialogic.start("03_04_02_robin_nextstep")
	#GameManager.met_robin = true
	
