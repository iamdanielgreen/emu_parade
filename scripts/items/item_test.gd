#NOTE: The DevWorm video on Collectable Objects also deals with objects that spawn and instantiate.
#This video also deals with position animations that drop from other sprites. 

extends Sprite2D

@onready var get_rubbish: CanvasLayer = $"../RubbishCollect"
@onready var continue_button: Button = $"../RubbishCollect/VBoxContainer/ContinueButton"

var player_in_area = false
var paused = false

func _ready() -> void:
	self.show()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta) -> void:
	if player_in_area:
		if Input.is_action_just_pressed("action"):
			print("YOU GOT THE RUBBISH.")
			queue_free()
			#getRubbish()

func _on_collect_radius_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		player_in_area = true

func _on_collect_radius_body_exited(body: Node2D) -> void:
	player_in_area = false

#TODO: This was an attempt to make a cutscene based around item collection, but you couldn't make it work.
#func getRubbish():
	#if paused:
		#get_rubbish.hide()
		#get_tree().paused = false
		#print("Game should be running now.")
	#else:
		#get_rubbish.show()
		#get_tree().paused = true
		#continue_button.grab_focus()
		#print("Game is paused.")
		#
	#paused = !paused #TODO: Someone needs to explain to you what this means.
