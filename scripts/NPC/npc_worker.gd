extends CharacterBody2D

@onready var worker_sprite = $AnimatedSprite2D

var player_in_area = false

#TODO: Why does this work, but the function below doesn't?
#func _ready() -> void:
	#Dialogic.start("meet_the_worker")
	
func _process(delta):
	if player_in_area and Input.is_action_pressed("action"):
		if Dialogic.current_timeline == null:
			Dialogic.start("worker")
			
			
	

func _physics_process(delta: float) -> void:
	worker_sprite.play("Idle")
	

func _on_convo_bubble_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		player_in_area = true
	#if body is CharacterBody2D and Input.is_action_pressed("action"):
		#print("Dialogue should be happening.")
		#if Dialogic.current_timeline == null:
				#Dialogic.start("meet_the_worker")
				
func _on_convo_bubble_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		player_in_area = false

#TODO: Does not currently work.
#func _on_area_2d_body_entered(body: Node2D) -> void:
	#if body.is_in_group("player") and Input.is_action_pressed("action"):
		#print("Dialogue should be happening.")
		#if Dialogic.current_timeline == null:
				#Dialogic.start("meet_the_worker")



		 
   
