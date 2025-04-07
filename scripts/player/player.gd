extends CharacterBody2D
class_name Player #NOTE: THIS CONNECTS TO THE PAUSE MENU, SO THAT YOU CAN STOP CASSIE MOVING WHEN THE GAME IS PAUSED.

@onready var cassie_sprite = $AnimatedSprite2D
@onready var interact_ui: CanvasLayer = $InteractUI
@onready var inventory_ui: CanvasLayer = $InventoryUI

const SPEED = 175.0 # Default is 300. 150 too slow, 200 too fast.
var paused = false

func _ready() -> void:
	#Set this node as the Player node
	GameManager.set_player_reference(self)

func _physics_process(delta: float) -> void:
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

func player():
	pass
