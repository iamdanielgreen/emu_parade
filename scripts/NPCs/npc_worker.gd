extends CharacterBody2D

@onready var worker_sprite = $AnimatedSprite2D
@onready var player: Player = $"../Player"

var player_in_range = false
var paused = false

#TODO: Why does this work, but the function below doesn't?
#func _ready() -> void:
	#Dialogic.start("worker")
	
func _process(delta):
	if player_in_range and Input.is_action_pressed("action"):
		if Dialogic.current_timeline == null:
			#TODO: STOP CASSIE MOVING
			Dialogic.start("worker")
			#TODO: RESUME CASSIE MOVING


func _physics_process(delta: float) -> void:
	worker_sprite.play("Idle")
	

func _on_convo_bubble_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_in_range = true
	#if body is CharacterBody2D and Input.is_action_pressed("action"):
		#print("Dialogue should be happening.")
		#if Dialogic.current_timeline == null:
				#Dialogic.start("worker")
				
func _on_convo_bubble_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_in_range = false

#TODO: Does not currently work.
#func _on_area_2d_body_entered(body: Node2D) -> void:
	#if body.is_in_group("player") and Input.is_action_pressed("action"):
		#print("Dialogue should be happening.")
		#if Dialogic.current_timeline == null:
				#Dialogic.start("worker")
