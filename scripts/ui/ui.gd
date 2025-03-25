extends Node

@onready var inventory: Node2D = $Inventory
var paused = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("inventory"):
		#$Inventory.visible = !$Inventory.visible
		showInventory()

func showInventory():
	if paused:
		inventory.hide()
		get_tree().paused = false
		print("Game should be running now.")
	else:
		inventory.show()
		get_tree().paused = true
		print("Game is paused.")
		
	paused = !paused #TODO: Someone needs to explain to you what this means.
