extends CharacterBody2D

@onready var cassie_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var interact_ui: CanvasLayer = $InteractUI
@onready var bed_sleeping: TileMapLayer = $"../TileLayers/Bed/BedSleeping"
@onready var player: Player = $"../Player"

var paused = false
var awake = false

func _ready() -> void:
	#Set this node as the Player node
	GameManager.set_player_reference(self)
	cassie_sprite.play("Sleeping")
	

func _physics_process(delta: float) -> void:
	
	if paused:
		return
		
	if Input.is_action_pressed("move_right"):
		make_bed()
	elif Input.is_action_pressed("move_left"):
		make_bed()
	elif Input.is_action_pressed("move_up"):
		make_bed()
	elif Input.is_action_pressed("move_down"):
		make_bed()
	else:
		return
		
func make_bed():
	if !awake:
		player.awake = true
		queue_free()
