#NOTE: THIS SCRIPT INCORPORATES CODE FROM OOPS, I DEV'D/@CHRISTINEC_DEVS (https://youtu.be/tzr-81qnS5g)
@tool
extends Node2D

#Item float animation player reference
@onready var item_float: AnimationPlayer = $AnimationPlayer

#Item details for editor window.
@export var quantity: int
@export var item_type = ""
@export var item_name = ""
@export var item_texture: Texture
@export var item_effect = ""

var scene_path: String = "res://scenes/items/inventory_item.tscn"

#Scene Tree node references
@onready var icon_sprite = $Sprite2D

var player_in_range = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	item_float.play("float")
	if not Engine.is_editor_hint():
		icon_sprite.texture = item_texture #Sets texture in game.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Engine.is_editor_hint():
		icon_sprite.texture = item_texture #Sets texture in editor.
	
	if player_in_range and Input.is_action_just_pressed("action"):
		pickup_item()
		
#Add item to inventory
func pickup_item():
	var item = {
		"quantity": 1, #HERE AS A CONST, BUT THEORETICALLY YOU COULD @EXPORT THIS. HECK, YOU DID ANYWAY.
		"type": item_type,
		"name": item_name,
		"effect": item_effect,
		"texture": item_texture,
		"scene_path": scene_path
	}
	
	if GameManager.player_node:
		GameManager.add_item(item)
		self.queue_free()

#If player is in range, show UI prompt and make item pickable
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_in_range = true
		body.interact_ui.visible = true

#If player is not in range, hide UI prompt and don't make item pickable
func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_in_range = false
		body.interact_ui.visible = false
		
#Sets the item's dictionary data
func set_item_data(data):
	item_type = data["type"]
	item_name = data["name"]
	item_effect = data["effect"]
	item_texture = data["texture"]
		
#Sets item values for spawning #TODO: COMMENT THIS OUT ONCE YOU'RE DONE TESTING
func initiate_items(type, name, effect, texture):
	item_type = type
	item_name = name
	item_effect = effect
	item_texture = texture
