extends Node2D

@onready var tv_animation: AnimationPlayer = $AnimationPlayer
@onready var player: Player = $Player

var paused = false
var player_in_range = false
var dad_message = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if player_in_range and Input.is_action_pressed("action"):
		if Dialogic.current_timeline == null and !dad_message:
			Dialogic.start("01_02_DadMessage")
			dad_message = true
		else:
			if Dialogic.current_timeline == null and dad_message:
				random_phone()

func _physics_process(delta: float) -> void:
	if player.paused:
		return

func _on_item_zone_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		pass
		#TV GLOW
		#phone_sprite.play("glow")
		
func _on_interact_zone_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_in_range = true
		body.interact_ui.visible = true

func _on_interact_zone_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_in_range = false
		body.interact_ui.visible = false

func _on_item_zone_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		pass
		#REMOVE TV GLOW
		#phone_sprite.play("idle")

func random_phone():
	Dialogic.timeline_ended.connect(dialogue_end) #Tutorial says "ended_dialogue" instead.
	#var dialogue_line = randi_range(0,3) 
	#Dialogic.start("random_" + str(dialogue_line))
	var dialogue_line = randi_range(0,3) 
	#CHANGE FOR TV CHANNEL
	Dialogic.start("random_phone_" + str(dialogue_line))
	#RANDOMISE SPRITE SHOW AS WELL
	
func dialogue_end():
	Dialogic.timeline_ended.disconnect(dialogue_end)
