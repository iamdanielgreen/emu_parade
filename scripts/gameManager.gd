# TODO: HAVE YOU SET THIS AS A GLOBAL, DANIEL?
extends Node2D

func _ready() -> void:
	pass
	#TODO: Remove tutorial code
	#Dialogic.signal_event.connect(_on_dialogic_signal)
	#Dialogic.start("tutorial_timeline")


func _process(delta: float) -> void:

	if Input.is_action_just_pressed("quit"):
		get_tree().quit()

#TODO: Remove tutorial code
#func _on_dialogic_signal(argument: String):
	#if argument == "it's a signal":
		#print("A signal was fired via Dialogic")
