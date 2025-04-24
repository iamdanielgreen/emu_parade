extends Node2D

@onready var phone_sprite: AnimationPlayer = $AnimationPlayer
@onready var player: Player = $"../Player"
@onready var interact_icon: Sprite2D = $InteractIcon

#var paused = false TODO: DO YOU NEED THIS?
var player_in_range = false
var phone_found = false
var dad_message = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if player_in_range and Input.is_action_pressed("action"):
		player.interact_ui.visible = false
		phone_found = true
		GameManager.phone_found = true
		if Dialogic.current_timeline == null and !dad_message:
			Dialogic.start("01_02_DadMessage")
			dad_message = true
		else:
			if Dialogic.current_timeline == null and dad_message:
				random_phone()

#TODO: DID YOU NEED THIS?
#func _physics_process(delta: float) -> void:
	#pass
	##if player.paused:
		##return

func _on_item_zone_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		phone_sprite.play("glow")
		
func _on_interact_zone_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_in_range = true
		interact_icon.show()
		if phone_found == true:
			return
		else:
			body.interact_ui.visible = true

func _on_interact_zone_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_in_range = false
		interact_icon.hide()
		body.interact_ui.visible = false

func _on_item_zone_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		phone_sprite.play("idle")

func random_phone():
	Dialogic.timeline_ended.connect(dialogue_end) #Tutorial says "ended_dialogue" instead.
	var dialogue_line = randi_range(0,4) 
	Dialogic.start("random_phone_" + str(dialogue_line))
	
func dialogue_end():
	Dialogic.timeline_ended.disconnect(dialogue_end)
