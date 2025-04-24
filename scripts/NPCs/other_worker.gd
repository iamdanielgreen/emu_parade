extends CharacterBody2D

@onready var other_worker = $AnimatedSprite2D


var player_in_range = false
var met_bob = false

func _process(delta):
	if player_in_range and Input.is_action_pressed("action"):
		if Dialogic.current_timeline == null and !met_bob:
			Dialogic.start("meet_bob")
			met_bob = true
		else:
			if Dialogic.current_timeline == null and met_bob:
				random_dialogue()
			

func _physics_process(delta: float) -> void:
	other_worker.play("Idle")
	
func random_dialogue(): #Tutorial calls this "run_rando_dialogue"
	Dialogic.timeline_ended.connect(dialogue_end) #Tutorial says "ended_dialogue" instead.
	
	#TODO: STOP CASSIE MOVING
	var dialogue_line = randi_range(0,3) 
	Dialogic.start("random_" + str(dialogue_line))
	#TODO: RESUME CASSIE MOVING

func dialogue_end():
	Dialogic.timeline_ended.disconnect(dialogue_end)

func _on_convo_bubble_body_entered(body: Node2D) -> void:
	#if body.has_method("player"):
	if body.is_in_group("player"):
		player_in_range = true

func _on_convo_bubble_body_exited(body: Node2D) -> void:
	#if body.has_method("player"):
	if body.is_in_group("player"):
		player_in_range = false
