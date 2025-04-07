extends Control

@onready var grid_container: GridContainer = $GridContainer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#Connect function to signal to update inventory UI
	GameManager.inventory_updated.connect(_on_inventory_updated)
	_on_inventory_updated()
	
#Update Inventory UI
func _on_inventory_updated(): #NOTE: UNDERSCORE AT FRONT DENOTES FUNCTION CONNECTS TO SIGNAL
	clear_grid_container()
	
#Clear Inventory UI grid
func clear_grid_container():
	while grid_container.get_child_count() > 0:
		var child = grid_container.get_child(0)
		grid_container.remove_child(child)
		child.queue_free()
