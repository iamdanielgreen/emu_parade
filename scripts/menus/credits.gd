extends Control

@onready var continue_button: Button = $Credits/ContinueButton

func _ready() -> void:
	continue_button.grab_focus()	
	
func _on_continue_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/levels/level_03a_emuparadegardens.tscn")


func _on_quit_pressed() -> void:
	get_tree().quit()
