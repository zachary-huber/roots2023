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
var currentPlunger
var isConnected = false
var canLaunchPlunger = true

var numUprooted = 0
var points 
var isEnd = false


func _ready():
	$tether.set_as_toplevel(true)
	$smoker.local_coords = false
	pass


func _process(delta):
	steering = lerp(steering, Input.get_axis("right", "left") * 0.4, 5 * delta)
	acceleration = Input.get_axis("back", "forward")
	rpm = abs($L3.get_rpm())
	$L3.engine_force = acceleration * max_torque * (1 - rpm / max_rpm)
	rpm = abs($L4.get_rpm())
	$L4.engine_force = acceleration * max_torque * (1 - rpm / max_rpm)
	
	if($L3.get_rpm()) > -30:
		$backupSound.playing = true

	if(isConnected):
		#points = [$tetherAnchor.global_translation, currentPlunger.global_translation]
		#points = [Vector3.ZERO, currentPlunger.global_translation + global_translation] #currentPlunger.global_translation]
		var point1 = $tetherAnchor.global_translation
		var point2 = currentPlunger.get_node("tetherAnchor").global_transform.origin
		point1.y -= 7
		point1.z += 1
		point1.x -= 0.5
		point2.y -= 7
		point2.x -= 1
		point2.z += 1
		points = [point1, point2]
		$tether.set_points(points)
		pass

func _input(event):
	if event.is_action_pressed("launch"):
		if canLaunchPlunger:
			launchPlunger()
		else:
			retractPlunger()


func launchPlunger():
	print("Launching plunger")
	var plungerShot = createPlunger()
	$plungerProjectile.visible = false
	currentPlunger = plungerShot # for conencting tether to right plunger
	isConnected = true
	canLaunchPlunger = false
	
	$tether.visible = true
	$launcherSound.play()
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
	
func retractPlunger():
	isConnected = false
	currentPlunger.queue_free()
	canLaunchPlunger = true
	$tether.visible = false
	$plungerProjectile.visible = true
