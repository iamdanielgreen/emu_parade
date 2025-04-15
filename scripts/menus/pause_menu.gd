extends CanvasLayer

@onready var resume_button: Button = $VBoxContainer/resume_button
@onready var pause_menu: CanvasLayer = $"."
@onready var player: Player = $"../../Player"


var paused = false

func _process(delta):
	if Input.is_action_just_pressed("pause"):
		pauseMenu()
				
func pauseMenu():
	if paused:
		pause_menu.hide()
		player.paused = false
		get_tree().paused = false
		
	else:
		pause_menu.show()
		resume_button.grab_focus()
		player.paused = true
		get_tree().paused = true
		
	paused = !paused #TODO: Someone needs to explain to you what this means. #NOTE 06/04/25: YOU NOW KNOW THIS IS A FLIP-FLOP.
	


func _on_resume_button_pressed() -> void:
	pauseMenu()

func _on_main_menu_button_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/menus/main_menu.tscn")
