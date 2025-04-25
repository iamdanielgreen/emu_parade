#NOTE: THESE ARE YOUR GUIDING PRINCIPLES.
#When Cassie meets a new person, that will trigger a conversation.
#If she has met them before, it will trigger a series of other conversations.
#If she has met them before, and met the prior person in the quest sequence, it will trigger a third conversation.


extends CharacterBody2D

@onready var THISONE_animation: AnimatedSprite2D = $AnimatedSprite2D
@onready var player: Player = $"../../Player"
@onready var talk_icon: Sprite2D = $TalkIcon

var player_in_range = false
var met_THISONE = false

func _process(delta):
	if player_in_range and Input.is_action_pressed("action"):
		if Dialogic.current_timeline == null and !met_THISONE:
			talk_icon.hide()
			player.talk_ui.visible = false
			Dialogic.start("03_00_MEET_THISONE")
			met_THISONE = true
		else:
			if Dialogic.current_timeline == null:
				if GameManager.met_THATONE == true:
					next_step()
				else:
					random_dialogue()



func _physics_process(delta: float) -> void:
	THISONE_animation.play("Idle")
	
	
func random_dialogue(): #Tutorial calls this "run_rando_dialogue"
	Dialogic.timeline_ended.connect(dialogue_end) #Tutorial says "ended_dialogue" instead.
	talk_icon.hide()
	var dialogue_line = randi_range(0,3) 
	Dialogic.start("03_00_THISONE_random_" + str(dialogue_line))

func dialogue_end():
	Dialogic.timeline_ended.disconnect(dialogue_end)


func _on_interact_zone_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_in_range = true
		talk_icon.show()
		if GameManager.met_maggie == true:
			return
		else:
			body.talk_ui.visible = true

func _on_interact_zone_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_in_range = false
		talk_icon.hide()
		body.talk_ui.visible = false
		
func next_step():
	Dialogic.start("03_00_LINK_TO_NEXT_PERSON")
	GameManager.met_THATONE = true
	
