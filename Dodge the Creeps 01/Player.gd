extends Area2D

signal hit

export var speed = 400 # How fast the Player will move in pixels per second.
var screen_size        # Size of the game window.
#var target = Vector2() # This variable holds the clicked position.

func _ready():
	screen_size = get_viewport_rect().size # Gets the screen size of the game window.
	hide()                                 # Player will be hidden when game starts.

#The process function is run every frame.
func _process(delta):                            # 'delta' refers to the frame length, or the 
	                                             # amount of time that the previous frame took to complete.
	var velocity = Vector2()                     # The player's movement vector.
	# Move towards the target and stop when close.
	#if position.distance_to(target) > 10:
	#	velocity = target - position
	
	# Original keyboard controls. Switching to mouse control and touch control.
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
	
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed # 'normalized()' makes it so the Player doesn't 
		                                         # move faster if traveling diagonally.
		$AnimatedSprite.play()                   # $ is shorthand for get_node()
	else:
		$AnimatedSprite.stop()
	
	position += velocity * delta
	position.x = clamp(position.x, 0, screen_size.x) # Clamping a value restricts it to a given range.
	position.y = clamp(position.y, 0, screen_size.y) # Here, 'clamp()' is preventing the Player from 
	                                                 # leaving the screen.
	if velocity.x != 0: # Moving left or right.
		$AnimatedSprite.animation = "walk"
		$AnimatedSprite.flip_v = false
		$AnimatedSprite.flip_h = velocity.x < 0 # If x velocity is less than zero, then going to left
		                                        # and flip_h will be true. If false, flip_h is false.
	elif velocity.y != 0: # Moving up or down.
		$AnimatedSprite.animation = "up"
		$AnimatedSprite.flip_v = velocity.y > 0

# When the Player hits an enemy.
func _on_Player_body_entered(_body):
	hide()             # Player disappears after being hit.
	emit_signal("hit") # Each time an enemy hits the player, the signal is emitted.
	$CollisionShape2D.set_deferred("disabled", true) # Disables the player's collision so 'hit' isn't 
	                                                 # triggered again.

#Resets the player when starting a new game.
func start(pos):
	position = pos
	# Initial target is the start position
	#target = pos
	show()
	$CollisionShape2D.disabled = false

# Change the target whenever a touch event happens.
#func _input(event):
#	if event is InputEventScreenTouch and event.pressed:
#		target = event.position

