extends CharacterBody2D

@onready var worker_sprite = $AnimatedSprite2D
#TODO: Why does this work, but the function below doesn't?
#func _ready() -> void:
	#Dialogic.start("meet_the_worker")

func _physics_process(delta: float) -> void:
	worker_sprite.play("Idle")
	


#TODO: Does not currently work.
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") and Input.is_action_pressed("action"):
		if Dialogic.current_timeline == null:
				Dialogic.start("meet_the_worker")



		 
   
