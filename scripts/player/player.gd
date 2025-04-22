extends CharacterBody2D
class_name Player #NOTE: THIS CONNECTS TO THE PAUSE MENU, SO THAT YOU CAN STOP CASSIE MOVING WHEN THE GAME IS PAUSED.

@onready var cassie_sprite = $AnimatedSprite2D
@onready var interact_ui: CanvasLayer = $InteractUI
@onready var inventory_ui: CanvasLayer = $InventoryUI
@onready var bed_sleeping: TileMapLayer = $"../TileLayers/Bed/BedSleeping"
@onready var test_bin: Node2D = $"../TestBin"

#@onready var inventory_item: Button = $ItemButton #NOTE: NOT PRESENTLY CALLED.

const SPEED = 175.0 # Default is 300. 150 too slow, 200 too fast.
var paused = false
var item = null
var hold_key = false
var awake = false

func _ready() -> void:
	#Set this node as the Player node
	GameManager.set_player_reference(self)

func _physics_process(delta: float) -> void:
	if awake:
		visible = true
		#NOTE: THIS DOESN'T WORK THE WAY YOU WANT IT TO, AND YOU DON'T KNOW WHY.
		if GameManager.current_scene == "level_01_bedroom":
			bed_sleeping.visible = false
		else:
			return
	else:
		visible = false
	
	if paused:
		return
		
	if Input.is_action_pressed("move_right"):
		# Move as long as the key/button is pressed.
		position.x += SPEED * delta
		cassie_sprite.play("Walk_Right")
	elif Input.is_action_pressed("move_left"):
		position.x -= SPEED * delta
		cassie_sprite.play("Walk_Left")
	elif Input.is_action_pressed("move_up"):
		position.y -= SPEED * delta
		cassie_sprite.play("Walk_Up")
	elif Input.is_action_pressed("move_down"):
		position.y += SPEED * delta
		cassie_sprite.play("Walk_Down")
	else:
		if Input.is_action_just_released("move_right"):
			cassie_sprite.play("Idle_Right")
		elif Input.is_action_just_released("move_left"):
			cassie_sprite.play("Idle_Left")
		elif Input.is_action_just_released("move_up"):
			cassie_sprite.play("Idle_Up")
		elif Input.is_action_just_released("move_down"):
			cassie_sprite.play("Idle")
	
	move_and_collide(velocity * delta)
	
func _input(event):
	if event.is_action_pressed("inventory"):
		inventory_ui.visible = !inventory_ui.visible
		#NOTE: THIS TYPE OF THING IS A FLIP-FLOP. PRESSING THE E KEY DOES THE OPPOSITE OF WHATEVER IS ACTIVE.
		#get_tree().paused = !get_tree().paused #NOTE: DISABLED BECAUSE IT WAS CAUSING WEIRDNESS.
		#NOTE: PROCESS HAS BEEN SET TO ALWAYS, DOES THIS MEAN CASSIE CAN STILL MOVE WHILST PAUSED?
		#NOTE: SHORT ANSWER IS YES. MAYBE THAT'S OK?
		


func apply_item_effect(item):
	match item["effect"]:
		"Stamina":
			pass
			#NOTE: COMMENTED CODE BELOW IS BECAUSE YOU HAVE NO VAR CALLED SPEED, BUT THE TUTORIAL DOES.
			#speed += 50
			#print("Speed increased to ", speed)
		"Slot Boost": 
			GameManager.increase_inventory_size(5)
			print("Slots increased to ", GameManager.inventory.size())
		"Key":
			hold_key = true
			if test_bin.player_in_bin_range:
				print("YOU TOOK OUT THE TRASH")
				
		_:
			print("There is no effect for this item.")
