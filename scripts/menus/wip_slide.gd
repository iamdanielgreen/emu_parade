extends Control

#TODO: At present you have the SELECT/SHARE/BACK/- controller buttons set to hard quit the game. 

@onready var continue_button: Button = $TitleScreen/VBoxContainer/ContinueButton

func _ready() -> void:
	continue_button.grab_focus()	

func _on_continue_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/levels/level_01_bedroom.tscn")
	
func _on_quit_pressed() -> void:
	get_tree().quit()
