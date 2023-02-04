extends Spatial



func _ready():
	pass # Replace with function body.


#func _process(delta):
#	pass


func _on_floorArea_body_entered(body):
	if body.has_method("isPlunger"):
		body.velocity = Vector3.ZERO
		body.rotation = Vector3.ZERO + Vector3(74.3, 0, 0)
