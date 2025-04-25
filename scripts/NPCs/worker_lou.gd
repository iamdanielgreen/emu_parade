extends CharacterBody2D

@onready var other_worker = $AnimatedSprite2D
@onready var interact_zone: Area2D = $CollisionShape2D/InteractZone
@onready var talk_icon: Sprite2D = $TalkIcon
@onready var player: Player = $Player


var player_in_range = false
var met_lou = false
var lou_test = false

func _process(delta):
	if player_in_range and Input.is_action_pressed("action"):
		if Dialogic.current_timeline == null and !met_lou:
			talk_icon.hide()
			Dialogic.start("03_02_meet_lou")
			met_lou = true
		else: 
			if Dialogic.current_timeline == null and met_lou:
				random_lou()
			


func _physics_process(delta: float) -> void:
	other_worker.play("Idle")
	
func random_lou(): #Tutorial calls this "run_rando_dialogue"
	Dialogic.timeline_ended.connect(dialogue_end) #Tutorial says "ended_dialogue" instead.
	
	#TODO: STOP CASSIE MOVING
	var dialogue_line = randi_range(0,3) 
	Dialogic.start("03_02_lou_random_" + str(dialogue_line))
	#TODO: RESUME CASSIE MOVING

func dialogue_end():
	Dialogic.timeline_ended.disconnect(dialogue_end)

func _on_interact_zone_body_entered(body: Node2D) -> void:
		if body.is_in_group("player"):
			talk_icon.show()
			player_in_range = true

func _on_interact_zone_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		talk_icon.hide()
		player_in_range = false
