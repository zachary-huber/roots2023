extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_plungeButton_pressed():
	var _newscene = get_tree().change_scene("res://scenes/Main.tscn")


func _on_dontButton_pressed():
	get_tree().quit()
