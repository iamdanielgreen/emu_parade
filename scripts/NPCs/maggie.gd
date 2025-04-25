extends CharacterBody2D

@onready var other_worker = $AnimatedSprite2D
@onready var maggie_animation: AnimatedSprite2D = $AnimatedSprite2D
@onready var player: Player = $"../../Player"
@onready var talk_icon: Sprite2D = $TalkIcon

var player_in_range = false
var met_maggie = false
var persistent_player = false

func _process(delta):
	if player_in_range and Input.is_action_pressed("action"):
		if Dialogic.current_timeline == null and !met_maggie:
			talk_icon.hide()
			player.talk_ui.visible = false
			Dialogic.start("03_maggie01_meet_maggie")
			met_maggie = true
			GameManager.met_maggie = true
			GameManager.helped_robin = true # TODO: DELETE AFTER TESTING
		else:
			if Dialogic.current_timeline == null and met_maggie:
				if persistent_player == true:
					maggie_bonus()
				else:
					talk_icon.hide()
					Dialogic.start("03_maggie02_demoend")
					persistent_player = true



func _physics_process(delta: float) -> void:
	if met_maggie == true:
		maggie_animation.play("Idle_Talking")
	else:
		maggie_animation.play("Idle_Up")
	
func maggie_bonus(): #Tutorial calls this "run_rando_dialogue"
	Dialogic.timeline_ended.connect(dialogue_end) #Tutorial says "ended_dialogue" instead.
	talk_icon.hide()
	var dialogue_line = randi_range(0,3) 
	Dialogic.start("03_maggie_bonus_" + str(dialogue_line))

func dialogue_end():
	Dialogic.timeline_ended.disconnect(dialogue_end)


func _on_interact_zone_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_in_range = true
		talk_icon.show()
		if met_maggie == true:
			return
		else:
			body.talk_ui.visible = true

func _on_interact_zone_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_in_range = false
		talk_icon.hide()
		body.talk_ui.visible = false
