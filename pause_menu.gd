extends CanvasLayer

@onready var resume_button: Button = $VBoxContainer/resume_button
@onready var pause_menu: CanvasLayer = $"."

var paused = false

#TODO: Pretty sure this is redundant.
#func _ready() -> void:
	#self.hide()

func _process(delta):
	if Input.is_action_just_pressed("pause"):
		pauseMenu()
		#self.show()
		#get_tree().paused = true
		resume_button.grab_focus()
		
func pauseMenu():
	if paused:
		#pause_menu.hide()
		get_tree().paused = false
		print("Game should be running now.")
	else:
		#pause_menu.show()
		get_tree().paused = true
		print("Game is paused.")
		
	#paused = !paused #TODO: Someone needs to explain to you what this means.

#TODO: Re-enable once you want menu to appear.
#func _on_resume_button_pressed() -> void:
	#pauseMenu()
#
#func _on_main_menu_button_pressed() -> void:
	#get_tree().paused = false
	#get_tree().change_scene_to_file("res://scenes/menus/main_menu.tscn")
