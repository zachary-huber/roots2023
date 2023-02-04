extends VehicleBody


var max_rpm = 500
var max_torque = 500


func _ready():
	pass 

func _process(delta):
	steering = lerp(steering, Input.get_axis("right", "left") * 0.4, 5 * delta)
	var acceleration = Input.get_axis("back", "forward")
	var rpm = abs($L3.get_rpm())
	$L3.engine_force = acceleration * max_torque * (1 - rpm / max_rpm)
	rpm = abs($L4.get_rpm())
	$L4.engine_force = acceleration * max_torque * (1 - rpm / max_rpm)

func _input(event):
	if event.is_action_pressed("launch"):
		launchPlunger()


func launchPlunger():
	# launch plunger in an arc towards the point where the plungerRay collides/ends
	pass
