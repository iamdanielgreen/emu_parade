extends CharacterBody2D

@onready var cassie_sprite = $AnimatedSprite2D

const SPEED = 175.0 # Default is 300. 150 too slow, 200 too fast.

func _physics_process(delta: float) -> void:
	
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
		
	
	
	##Player Movement
	#var direction_x := Input.get_axis("walk_left", "walk_right")
	#if direction_x:
		#velocity.x = direction_x * SPEED
	#else:
		#velocity.x = move_toward(velocity.x, 0, SPEED)
		#
	#var direction_y := Input.get_axis("walk_up", "walk_down")
	#if direction_y:
		#velocity.y = direction_y * SPEED
	#else:
		#velocity.y = move_toward(velocity.y, 0, SPEED)
		#
	##Player Animations
	#if direction_x > 0.0:
		#cassie_sprite.play("Walk_Right")
	#elif direction_x < 0.0:
		#cassie_sprite.play("Walk_Left")
	#
	#if direction_x and direction_y == 0.0:
		#cassie_sprite.play("idle")
#
	#
	#if direction_y > 0.0:
		#cassie_sprite.play("Walk_Down")
	#elif direction_y < 0.0:
		#cassie_sprite.play("Walk_Up")
	
	
	move_and_collide(velocity * delta)
	
func player():
	pass
