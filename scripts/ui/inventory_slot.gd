extends Control

@onready var icon: Sprite2D = $OuterBorder/InnerBorder/ItemIcon
@onready var quantity_label: Label = $OuterBorder/InnerBorder/ItemQuantity
@onready var details_panel: ColorRect = $DetailsPanel
@onready var item_name: Label = $DetailsPanel/ItemName
@onready var item_type: Label = $DetailsPanel/ItemType
@onready var item_effect: Label = $DetailsPanel/ItemEffect
@onready var usage_panel: ColorRect = $UsagePanel

#Slot item
var item = null

#NOTE: YOU DON'T NEED THIS. ACTUALLY MAYBE YOU DO NEED THIS.
#Show usage panel for player to use/remove item 
func _on_item_button_pressed() -> void:
	if item != null:
		#NOTE: ORIGINAL CODE. DOESN'T WORK FOR SOME REASON.
		#usage_panel.visible != usage_panel.visible
		#details_panel.visible != details_panel.visible
		#NOTE: BELOW IS REPLACEMENT CODE. NOT PERFECT BUT WORKS.
		usage_panel.visible = true
		details_panel.visible = false

#Show details on mouse hover
func _on_item_button_mouse_entered() -> void:
	if item != null:
		usage_panel.visible = false
		details_panel.visible = true

#NOTE: DUPLICATE MOUSE ENTERED TO FOCUS ENTERED SCRIPT
func _on_item_button_focus_entered() -> void:
		if item != null:
			usage_panel.visible = false
			details_panel.visible = true

#Hide details on mouse hover exit
func _on_item_button_mouse_exited() -> void:
	details_panel.visible = false

#NOTE: DUPLICATE MOUSE EXIT TO FOCUS EXIT SCRIPT
func _on_item_button_focus_exited() -> void:
	details_panel.visible = false
	
#Default empty slot
func set_empty():
	icon.texture = null
	quantity_label.text = "" #TODO: DOES QUANTITY MATTER?

#Set slot item with its values from the dictionary
func set_item(new_item):
	item = new_item
	icon.texture = new_item["texture"]
	quantity_label.text = str(item["quantity"]) #TODO: DOES QUANTITY MATTER?
	item_name.text = str(item["name"])
	item_type.text = str(item["type"]) #TODO: THIS IS THE DESCRIPTION, YES?
	#TODO: THE EFFECT DOESN'T NEED TO BE SEEN. IT'S JUST A MARKER FOR YOU, YEAH?
	if item["effect"] != "":
		item_effect.text = str(item["effect"])
	else:
		item_effect.text = ""

##NOTE: YOU DON'T NEED THIS.
#func _on_drop_button_pressed() -> void:
	#if item != null:
		#var drop_position = GameManager.player_node.global_position
		#var drop_offset = Vector2(0, 50)
		#drop_offset = drop_offset.rotated(GameManager.player_node.rotation)
		#GameManager.drop_item(item, drop_position + drop_offset)
		#GameManager.remove_item(item["type"], item["effect"])
		#usage_panel.visible = false
#
##NOTE: YOU DON'T NEED THIS. ACTUALLY MAYBE YOU DO NEED THIS.
func _on_use_button_pressed() -> void:
	usage_panel.visible = false
	if item != null and item["effect"] != "":
		if GameManager.player_node:
			GameManager.player_node.apply_item_effect(item)
			GameManager.remove_item(item["type"], item["effect"])
			
		else:
			print("Player could not be found.")
