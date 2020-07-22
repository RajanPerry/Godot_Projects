extends RigidBody2D

# When a Mob is spawned, a random value between max and min will be chosen for how fast each 
# Mob will move.
export var min_speed=150 # Minimum speed range.
export var max_speed=250 # Maximum speed range.

func _ready():
	# Randomly choosing one of the three animation types.
	var mob_types = $AnimatedSprite.frames.get_animation_names() # Creating an Array containing 
	                                                             # all three animation names.
	#var mob_types = ["fly", "swim", "walk"]
	$AnimatedSprite.animation = mob_types[randi() % mob_types.size()] # Picking a random number between 0 and 2 
	                                                                  # to select a name from the Array.

# Deletes Mobs upon exiting the screen.
func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
