extends VehicleBody


onready var plungerProjectile = preload("res://scenes/plungerProjectile.tscn")
##########################
#  Car vars
##########################
var max_rpm = 500
var max_torque = 500
var velocity = Vector3(0,0,0)
var rpm = 0
var acceleration = Input.get_axis("back", "forward")
var tetherPoints = []
var tetherPoint: Vector2


func _ready():
	pass


func _process(delta):
	steering = lerp(steering, Input.get_axis("right", "left") * 0.4, 5 * delta)
	acceleration = Input.get_axis("back", "forward")
	rpm = abs($L3.get_rpm())
	$L3.engine_force = acceleration * max_torque * (1 - rpm / max_rpm)
	rpm = abs($L4.get_rpm())
	$L4.engine_force = acceleration * max_torque * (1 - rpm / max_rpm)

	
func _input(event):
	if event.is_action_pressed("launch"):
		launchPlunger()


func launchPlunger():
	print("Launching plunger")
	var plungerShot = createPlunger()
	plungerShot.velocity = plungerShot.transform.basis.x * (plungerShot.launchForce + $L3.get_rpm() / 10 )
	plungerShot.state = "active"
	pass


func resetPlunger(plungerEntity):
	plungerEntity.state = "inactive"
	translation = get_parent().get_node("plungerAnchorPoint").translation


func createPlunger():
	var plungerShot = plungerProjectile.instance()
	# set plunger rotation and translation
	get_parent().get_node("Level").add_child(plungerShot)
	plungerShot.rotation = $plungerLookTarget.global_rotation
	plungerShot.translation = $plungerLookTarget.global_translation
	return plungerShot
