extends Node

var startTime

func _ready():
	startTime = Time.get_unix_time_from_system()


func _input(event):
	if event.is_action_pressed("ui_cancel"):
		quitGame()
	if event.is_action_pressed("ui_restart"):
		restartGame()


func _process(delta):
	$HUD/stopwatch.text =  ".\nSTOPWATCH: " + String(stepify(Time.get_unix_time_from_system() - startTime, 1))

func quitGame():
	print("Quitting game...")
	var _newScene = get_tree().change_scene("res://scenes/menu.tscn")
	
func restartGame():
	print("Reloading current scene...")
	var _quit = get_tree().reload_current_scene()
