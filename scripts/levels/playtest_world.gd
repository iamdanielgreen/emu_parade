extends Node2D

@onready var scene_transition: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	#TODO: Fade in currently doesn't work.
	#scene_transition.get_parent().get_node("ColorRect").color.a = 255
	#scene_transition.play("fade_in")
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
