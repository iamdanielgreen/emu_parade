extends Node2D

@onready var tv_animation: AnimationPlayer = $AnimationPlayer
@onready var tv_sprite: Sprite2D = $tv_sprite
@onready var player: Player = $"../Player"
@onready var interact_icon: Sprite2D = $InteractIcon

var paused = false
var player_in_range = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if player_in_range and Input.is_action_pressed("action"):
		if Dialogic.current_timeline == null:
			tv_channel()
		if GameManager.phone_found == true:
			return
		else:
			player.interact_ui.visible = false
			GameManager.phone_found = true

#TODO: DO YOU NEED THIS?
#func _physics_process(delta: float) -> void:
	#if player.paused:
		#return

func _on_item_zone_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		tv_animation.play("glow")
		interact_icon.show()
		
func _on_interact_zone_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_in_range = true
		if GameManager.phone_found == true:
			return
		else:
			body.interact_ui.visible = true

func _on_interact_zone_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_in_range = false
		body.interact_ui.visible = false

func _on_item_zone_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		tv_animation.play("idle")
		interact_icon.hide()

func tv_channel():
	Dialogic.timeline_ended.connect(dialogue_end) #Tutorial says "ended_dialogue" instead.
	#var dialogue_line = randi_range(0,3) 
	#Dialogic.start("random_" + str(dialogue_line))
	interact_icon.hide()
	tv_sprite.frame = randi_range(1,3)
	var dialogue_line = randi_range(0,7) 
	#CHANGE FOR TV CHANNEL
	Dialogic.start("tv_channel_" + str(dialogue_line))
	#RANDOMISE SPRITE SHOW AS WELL
	
func dialogue_end():
	Dialogic.timeline_ended.disconnect(dialogue_end)
