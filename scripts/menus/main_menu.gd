extends Control

#TODO: At present you have the SELECT/SHARE/BACK/- controller buttons set to hard quit the game. 

@onready var start_button: Button = $TitleScreen/MainMenuButtons/StartGame
@onready var show_credits_button: Button = $TitleScreen/MainMenuButtons/Credits
@onready var show_feedback_button: Button = $"TitleScreen/MainMenuButtons/Playtest Feedback"
@onready var credits_back_button: Button = $Credits/CreditsBackButton
@onready var scene_transition = $SceneTransition/AnimationPlayer



func _ready() -> void:
	start_button.grab_focus()	

func _on_start_game_pressed() -> void:
	scene_transition.play("fade_out")
	await get_tree().create_timer(1.0).timeout
	get_tree().change_scene_to_file("res://scenes/levels/world.tscn")
	
func _on_credits_pressed() -> void:
	$"TitleScreen".hide()
	$"Credits".show()
	credits_back_button.grab_focus()

func _on_credits_back_button_pressed() -> void:
	$"Credits".hide()
	$"TitleScreen".show()
	start_button.grab_focus()
	
func _on_quit_pressed() -> void:
	get_tree().quit()
