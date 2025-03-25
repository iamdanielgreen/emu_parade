#NOTE: This is based on code by Arkeve (https://www.youtube.com/watch?v=FHYb63ppHmk) and @karthikraja8858, @agenturostufer4777

extends Node2D

var item_name
var item_quantity

func _ready() -> void:
	var rand_val = randi() % 3
	if rand_val == 0:
		item_name = "Iron Sword"
	elif rand_val == 1:
		item_name = "Tree Branch"
	else: 
		item_name = "Slime Potion"
		
	$TextureRect.texture = load("res://assets/01_Sprites/03_Items/InventoryTutorial/Items/" + item_name + ".png")
	var stack_size = int(jsonData.item_data[item_name]["StackSize"])
	item_quantity = randi() % stack_size + 1
	
	if stack_size == 1:
		$Label.visible = false
	else:
		$Label.text = str(item_quantity)
		
func add_item_quantity(amount_to_add):
	item_quantity += amount_to_add
	$Label.text = str(item_quantity)
	
func decrease_item_quantity(amount_to_remove):
	item_quantity += amount_to_remove
	$Label.text = str(item_quantity)
		
#NOTE: Just parking this incase I still need it.
	#if randi() % 2 ==0:
		#$TextureRect.texture = load("res://assets/01_Sprites/03_Items/InventoryTutorial/Items/Iron Sword.png")
	#else:
		#$TextureRect.texture = load("res://assets/01_Sprites/03_Items/InventoryTutorial/Items/Tree Branch.png")
