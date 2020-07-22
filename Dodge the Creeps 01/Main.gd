extends Node


export (PackedScene) var Mob
var score


# This makes it so random functions throughout all the scripts in this project work.
# I suppose it is like srand in C.
func _ready():
	randomize()
	#new_game() # Allows me to test the game to see that it is working.

func game_over():
	$ScoreTimer.stop()
	$MobTimer.stop()
	$HUD.show_game_over()
	# The 'call_group()' function calls the named function on every node in a group.
	# This function makes all the leftover mobs delete themselves.
	get_tree().call_group("mobs", "queue_free")
	$Music.stop()
	$DeathSound.play()


func new_game():
	score = 0
	$Player.start($StartPosition.position)
	$StartTimer.start()
	$HUD.update_score(score)
	$HUD.show_message("Get Ready")
	$Music.play()


# The StartTimer will start the two other timers.
func _on_StartTimer_timeout():
	$MobTimer.start()
	$ScoreTimer.start()


# Increments the score by 1.
func _on_ScoreTimer_timeout():
	score += 1;
	$HUD.update_score(score)


# Creates a Mob instance, picks a random starting point along the Path2D, and sets the Mob in motion.
func _on_MobTimer_timeout():
	# Choose a random location on Path2D.
	$MobPath/MobSpawnLocation.offset = randi()
	# Create a Mob instance and add it to the scene.
	var mob = Mob.instance()
	add_child(mob) # We add mob as a child because the node won't be executed until it becomes part 
	               # of the Scene Tree so it needs to be added as a child of Main.
	# Set the mob's direction perpendicular to the path direction.
	# In functions requiring angles, GDScript uses radians, not degrees.
	var direction = $MobPath/MobSpawnLocation.rotation + PI / 2
	# Set the mob's position to a random location.
	mob.position = $MobPath/MobSpawnLocation.position
	# Add some randomness to the direction.
	direction += rand_range(-PI / 4, PI / 4)
	mob.rotation = direction
	# Set the velocity (speed and direction).
	mob.linear_velocity = Vector2(rand_range(mob.min_speed, mob.max_speed), 0)
	mob.linear_velocity = mob.linear_velocity.rotated(direction)
	

