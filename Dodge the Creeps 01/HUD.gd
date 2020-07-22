extends CanvasLayer


# The 'start_game' signal tells the 'Main' node that the button has been pressed.
signal start_game


# This function displays a message temporarily.
func show_message(text):
	$MessageLabel.text = text
	$MessageLabel.show()
	$MessageTimer.start()


# This function is called when the player loses. It will show "Game Over" for 
# the Wait Time specified in the MessageTimer, then return to the title screen 
# and, after a brief pause, show  the "Start" button.
func show_game_over():
	show_message("Game Over")
	# Wait until the MessageTimer has counted down.
	yield($MessageTimer, "timeout")
	
	$MessageLabel.text = "Dodge the\nCreeps!"
	$MessageLabel.show()
	# Make a one-shot timer and wait for it to finish.
	yield(get_tree().create_timer(1), "timeout")
	$StartButton.show()


# This function is called by 'Main' whenever the score changes.
func update_score(score):
	$ScoreLabel.text = str(score)


func _on_StartButton_pressed():
	$StartButton.hide()
	emit_signal("start_game")


func _on_MessageTimer_timeout():
	$MessageLabel.hide()
