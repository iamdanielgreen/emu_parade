extends ColorRect

@onready var pause_menu: ColorRect = $"."
@onready var resume_button: Button = $VBoxContainer/resume_button
@onready var main_menu_button: Button = $VBoxContainer/main_menu_button

var paused = false

func _process(delta):
	if Input.is_action_just_pressed("pause"):
		pauseMenu()
		resume_button.grab_focus()

func pauseMenu():
	if paused:
		get_tree().paused = false
		pause_menu.hide()
	else:
		get_tree().paused = true
		pause_menu.show()
		
		
func _on_resume_button_pressed() -> void:
	pauseMenu()
	
func _on_main_menu_button_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/menus/main_menu.tscn")
