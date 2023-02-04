extends Line2D



func _ready():
	# draw 2D tether from unprojected position of 2 tetherAnchors
	var tetherAnchor = get_parent().get_node("tetherAnchor")
	var camera = get_parent().get_node("Camera")
	var tetherPoint = camera.unproject_position(tetherAnchor.translation)
	
	set_point_position(0, Vector2(-100,-100))
	set_point_position(1, Vector2(0,0))


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
