extends CanvasLayer

var paused = false

@onready var get_rubbish: CanvasLayer = $"."
@onready var continue_button: Button = $VBoxContainer/ContinueButton

func getRubbish():
	if paused:
		get_rubbish.hide()
		get_tree().paused = false
		print("Game should be running now.")
	else:
		get_rubbish.show()
		get_tree().paused = true
		continue_button.grab_focus()
		print("Game is paused.")	
		
func _on_continue_button_pressed() -> void:
	getRubbish()
	
