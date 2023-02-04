extends KinematicBody

#var states:enum = {"inactive", "active"}
var state = "inactive"
var gravity = -9.8


func _ready():
	resetPlunger()

#func _process(delta):
#	pass


func resetPlunger():
	translation = get_parent().get_node("plungerAnchorPoint").translation
