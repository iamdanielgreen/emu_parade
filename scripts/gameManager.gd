#NOTE: Incorporates code from Oops, I Dev'd (https://youtu.be/wLWs6KTsLIE)
#TODO: AND DEVWORM BUT YOU HAVEN'T ADDED THE LINK YET.

extends Node

var current_scene = "level_01_bedroom"
var transition_scene = false

#NOTE: COULD THIS LIVE IN LEVEL MANAGER? YES, PROBABLY.
var player_exit_bedroom_posx = 1100
var player_exit_bedroom_posy = 555
var player_awake_bedroom_posx = 1015
var player_awake_bedroom_posy = 390

var game_loadin = true

#GAME OBJECTIVE VARIABLES
var phone_found = false
var met_maggie = false


#Inventory items
var inventory = []

#NOTE: YOU PROBABLY DON'T NEED SPAWNABLE ITEMS, BUT IT'S GOOD FOR TESTING.
var spawnable_items = [
	#FORMAT -> {"type": "", "name": "", "effect": "", "texture": ""},
	#For example: {"type": "Consumable", "name": "Berry", "effect": "Health", "texture": preload("file_path")},
	{"type": "Consumable", "name": "Potion", "effect": "Health", "texture": preload("res://assets/01_Sprites/03_Items/InventoryTutorial/Items/Slime Potion.png")},
	{"type": "Quest", "name": "Rubbish", "effect": "It's a bag of rubbish, bruh.", "texture": preload("res://assets/01_Sprites/03_Items/InventoryTutorial/Items/Rubbish Bag.png")},
	{"type": "Some sort of description", "name": "Lime Bike", "effect": "Key", "texture": preload("res://assets/01_Sprites/03_Items/InventoryTutorial/Items/Iron Sword.png")}
	]

#Custom signals
signal inventory_updated

#Scene and node references
var player_node: Node = null
@onready var inventory_slot_scene = preload("res://scenes/ui/inventory_slot.tscn")

func _ready() -> void:
	#Initialises the inventory with 30 slots (spread over 9 slots per row)
	inventory.resize(30) #NOTE: TUTORIAL SETS THIS AT 30


#NOTE: THIS POTENTIALLY SOLVES YOUR CASSIE MOVING PROBLEM.
func transition_scene_end():
	if transition_scene == true:
		transition_scene = false
		if current_scene == "level_01_bedroom":
			current_scene = "level_02_livingroom"
		else:
			current_scene = "level_01_bedroom"

#Adds item to the inventory, returns true if successful
func add_item(item):
	for i in range(inventory.size()):
		#Check if the item exists in the inventory and matches type and effect
		if inventory[i] != null and inventory[i]["type"] == item["type"] and inventory[i]["effect"] == item["effect"]:
			inventory[i]["quantity"] += item["quantity"]
			inventory_updated.emit()
			print("item_added", inventory)
			return true
		elif inventory[i] == null:
			inventory[i] = item
			inventory_updated.emit()
			print("item_added", inventory)
			return true #Add to inventory
	return false 

#Removes an item from the inventory based on type and effect
func remove_item(item_type, item_effect):
	for i in range(inventory.size()):
		if inventory[i] != null and inventory[i]["type"] == item_type and inventory[i]["effect"] == item_effect:
			inventory[i]["quantity"] -= 1
			if inventory[i]["quantity"] <= 0:
				inventory[i] = null 
			inventory_updated.emit()
			return true
	return false

#Increase inventory size dynamically #NOTE: DON'T NEED THIS.
#func increase_inventory_size(extra_slots):
	#inventory.resize(inventory.size() + extra_slots)
	#inventory_updated.emit()
	
func set_player_reference(player):
	player_node = player
	
func adjust_drop_position(position):
	var radius = 100 #NOTE: CAN ADJUST AS NECESSARY
	var nearby_items = get_tree().get_nodes_in_group("Items")
	for item in nearby_items:
		if item.global_positon.distance_to(position) < radius:
			var random_offset = Vector2(randf_range(-radius, radius), randf_range(-radius, radius))
			position += random_offset
			break
	return position
	
func drop_item(item_data, drop_position):
	var item_scene = load(item_data["scene_path"])
	var item_instance = item_scene.instantiate()
	item_instance.set_item_data(item_data)
	drop_position = adjust_drop_position(drop_position)
	item_instance.global_position = drop_position
	get_tree().current_scene.add_child(item_instance)

	
	
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
