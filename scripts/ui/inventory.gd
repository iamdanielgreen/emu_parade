#NOTE: This is based on code by Arkeve (https://www.youtube.com/watch?v=FHYb63ppHmk) and @poemyint4366

extends Node2D

const SlotClass = preload("res://scripts/ui/inventory_slot.gd")
@onready var inventory_slots: GridContainer = $TextureRect/GridContainer
var holding_item = null

func _ready() -> void:
	for inv_slot in inventory_slots.get_children():
		inv_slot.gui_input.connect(slot_gui_input.bind(inv_slot))
		#inv_slot.connect("gui_input", self, "slot_gui_input", [inv_slot]) #Original tutorial script.

func slot_gui_input(event: InputEvent, slot: SlotClass):
	if event is InputEventMouseButton:  #But will it be mouse button?
		if event.button_index == MOUSE_BUTTON_LEFT && event.pressed:
			# Currently holding an item
			if holding_item != null: 
				# Empty slot
				if !slot.item: #Place holding item to slot
					slot.putIntoSlot(holding_item)
					holding_item = null #slot 
				# Slot already contains an item
				else: 
					#Different item, so swap
					var temp_item = slot.item
					slot.pickFromSlot
					temp_item.global_position = event.global_position
					slot.putIntoSlot(holding_item)
					holding_item = temp_item
			## Same item, try to merge NOTE: Doesn't really work. BUT YOU DON'T NEED THIS
			#else:
				#var stack_size = int(jsonData.item_data[slot.item.item_name]["StackSize"])
				#var able_to_add = stack_size - slot.item.item_quantity
				#if able_to_add >= holding_item.item_quantity:
					#slot.item.add_item_quantity(holding_item.item_quantity)
					#holding_item.queue_free()
					#holding_item = null
				#else:
					#slot.item.add_item_quantity(able_to_add)
					#holding_item.decrease_item_quantity(able_to_add)
			
			#Not holding an item
			elif slot.item:
				holding_item = slot.item
				slot.pickFromSlot()
				holding_item.global_position = get_global_mouse_position()
					
func _input(event):
	if holding_item:
		holding_item.global_position = get_global_mouse_position()
