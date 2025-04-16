extends Node2D

@onready var phone_sprite: AnimationPlayer = $AnimationPlayer

var player_in_range = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if player_in_range and Input.is_action_just_pressed("action"):
		if Dialogic.current_timeline == null:
			Dialogic.start("01_01_PhoneAlarm")

func _on_item_zone_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		phone_sprite.play("glow")
		
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
		phone_sprite.play("idle")
