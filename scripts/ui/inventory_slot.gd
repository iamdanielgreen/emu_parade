#NOTE: This is based on code by Arkeve (https://www.youtube.com/watch?v=FHYb63ppHmk)

extends Panel

var default_tex = preload("res://assets/01_Sprites/03_Items/InventoryTutorial/UI/item_slot_default_background.png")
var empty_tex = preload("res://assets/01_Sprites/03_Items/InventoryTutorial/UI/item_slot_empty_background.png")

var default_style: StyleBoxTexture = null
var empty_style: StyleBoxTexture = null

var ItemClass = preload("res://scenes/ui/inventory_item.tscn")
var item = null

func _ready() -> void:
	default_style = StyleBoxTexture.new()
	empty_style = StyleBoxTexture.new()
	default_style.texture = default_tex
	empty_style.texture = empty_tex
	
	if randi() % 2 == 0:
		item = ItemClass.instantiate()
		add_child(item)
	refresh_style()

# NOTE: "refresh_style()" was originally set up with "custom_styles/panel", but this changes for Godot 4.
func refresh_style():
	if item == null:
		set("theme_override_styles/panel", empty_style)
	else:
		set("theme_override_styles/panel", default_style)

func pickFromSlot():
	remove_child(item)
	var inventoryNode = find_parent("Inventory")
	inventoryNode.add_child(item)
	item = null
	refresh_style()
	
func putIntoSlot(new_item):
	item = new_item
	item.position = Vector2(0,0)
	var inventoryNode = find_parent("Inventory")
	inventoryNode.remove_child(item)
	add_child(item)
	refresh_style()
