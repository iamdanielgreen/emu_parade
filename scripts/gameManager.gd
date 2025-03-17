extends Node2D

var paused = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	#TODO: Remove tutorial code
	#Dialogic.signal_event.connect(_on_dialogic_signal)
	#Dialogic.start("tutorial_timeline")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	#TODO: PAUSE MENU - Doesn't work now. Needs canvas layers and such.
	#if Input.is_action_just_pressed("pause"):
		#if paused == false:
			#get_tree().paused = true
		#elif paused == true:
			#get_tree().paused = false

	if Input.is_action_just_pressed("quit"):
		get_tree().quit()

#TODO: Remove tutorial code
#func _on_dialogic_signal(argument: String):
	#if argument == "it's a signal":
		#print("A signal was fired via Dialogic")
