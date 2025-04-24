extends Control

#TODO: At present you have the SELECT/SHARE/BACK/- controller buttons set to hard quit the game. 

@onready var menu_button: Button = $TextFields/VBoxContainer/MainMenuButton


func _ready() -> void:
	menu_button.grab_focus()	

func _on_main_menu_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menus/main_menu.tscn")
	
func _on_quit_pressed() -> void:
	get_tree().quit()
