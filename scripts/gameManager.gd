extends Node



func _ready():
	pass # Replace with function body.


func _input(event):
	if event.is_action_pressed("ui_cancel"):
		quitGame()
	if event.is_action_pressed("ui_restart"):
		restartGame()


#func _process(delta):
#	pass

func quitGame():
	print("Quitting game...")
	get_tree().quit()
	
func restartGame():
	print("Reloading current scene...")
	get_tree().reload_current_scene()
