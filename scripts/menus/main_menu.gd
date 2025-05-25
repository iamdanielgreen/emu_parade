extends Control

#TODO: At present you have the SELECT/SHARE/BACK/- controller buttons set to hard quit the game. 

@onready var start_button: Button = $TitleScreen/MainMenuButtons/StartGame
@onready var show_credits_button: Button = $TitleScreen/MainMenuButtons/Credits
@onready var show_feedback_button: Button = $"TitleScreen/MainMenuButtons/PlaytestFeedback"
@onready var credits_back_button: Button = $Credits/CreditsBackButton
@onready var feedback_back_button: Button = $Feedback/FeedbackBackButton

func _ready() -> void:
	start_button.grab_focus()	

func _on_start_game_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/levels/level_01_bedroom.tscn")
	
func _on_credits_pressed() -> void:
	$"TitleScreen".hide()
	$"Credits".show()
	credits_back_button.show()
	credits_back_button.grab_focus()

func _on_credits_back_button_pressed() -> void:
	$"Credits".hide()
	$"TitleScreen".show()
	start_button.grab_focus()
	
func _on_playtest_feedback_pressed() -> void:
	$"TitleScreen".hide()
	$"Credits".hide()
	$"Feedback".show()
	feedback_back_button.show()
	feedback_back_button.grab_focus()

func _on_feedback_back_button_pressed() -> void:
	$"Feedback".hide()
	$"TitleScreen".show()
	start_button.grab_focus()

func _on_quit_pressed() -> void:
	get_tree().quit()
