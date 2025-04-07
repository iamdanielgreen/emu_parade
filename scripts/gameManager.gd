#NOTE: Incorporates code from Oops, I Dev'd (https://youtu.be/wLWs6KTsLIE)

# TODO: HAVE YOU SET THIS AS A GLOBAL, DANIEL?
extends Node

#Inventory items
var inventory = []

#Custom signals
signal inventory_updated

#Scene and node references
var player_node: Node = null

func _ready() -> void:
	#Initialises the inventory with 30 slots (spread over 9 slots per row)
	inventory.resize(30)

#Adds item to the inventory, returns true if successful
func add_item(item):
	for i in range(inventory.size()):
		#Check if the item exists in the inventory and matches type and effect
		if inventory[1] != null and inventory[1]["type"] == item["type"] and inventory[1]["effect"] == item["effect"]:
			inventory[1]["quantity"] += item["quantity"]
			inventory_updated.emit()
			print("item_added", inventory)
			return true
		elif inventory[i] == null:
			inventory[1] = item
			inventory_updated.emit()
			print("item_added", inventory)
			return true #Add to inventory
		return false

#Removes an item from the inventory based on type and effect
func remove_item():
	inventory_updated.emit()

#Increase inventory size dynamically
func increase_inventory_size():
	inventory_updated.emit()
	
func set_player_reference(player):
	player_node = player
	
	#TODO: REMOVE DIALOGIC TUTORIAL CODE
	#Dialogic.signal_event.connect(_on_dialogic_signal)
	#Dialogic.start("tutorial_timeline")


func _process(delta: float) -> void:

	if Input.is_action_just_pressed("quit"):
		get_tree().quit()

#TODO: Remove tutorial code
#func _on_dialogic_signal(argument: String):
	#if argument == "it's a signal":
		#print("A signal was fired via Dialogic")
