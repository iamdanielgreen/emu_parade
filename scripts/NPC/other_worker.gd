extends CharacterBody2D

@onready var other_worker = $AnimatedSprite2D

var player_in_area = false

func _process(delta):
	if player_in_area and Input.is_action_pressed("action"):
		if Dialogic.current_timeline == null:
			random_dialogue()
			

func _physics_process(delta: float) -> void:
	other_worker.play("Idle")
	
func random_dialogue(): #Tutorial calls this "run_rando_dialogue"
	Dialogic.timeline_ended.connect(dialogue_end) #Tutorial says "ended_dialogue" instead.
	
	var dialogue_line = randi_range(0,3) 
	Dialogic.start("random_" + str(dialogue_line))

func dialogue_end():
	Dialogic.timeline_ended.disconnect(dialogue_end)

func _on_convo_bubble_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		player_in_area = true

func _on_convo_bubble_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		player_in_area = false
