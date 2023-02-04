extends StaticBody


var isTethered = false
var isUprooted = false
var connectedPlunger

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(isTethered):
		pass


func _on_PlungerDetector_body_entered(body):
	if body.has_method("isPlunger") and (!isUprooted):
		connectedPlunger = connectPlunger(body)


func connectPlunger(body):
	print("connecting plunger to vegetable")
	#body.velocity = Vector3.ZERO
	body.translation = translation
	body.translation.y += 1
	body.state = "inactive"
	body.scale = Vector3(.8,.8,.8)
	
	# activate the pulling detector
	$PullingDistance.monitorable = true
	$PullingDistance.monitoring = true
	
	# apply particle affect
	
	# play suction sound effect
	
	return body



func uproot():
	if(!isUprooted):
		print("uprooting vegetable!")
		isUprooted = true
		$PullingDistance.monitorable = false
		$PullingDistance.monitoring = false
		
		connectedPlunger.visible = false
		
		# hide self
		#visible = false
		
		# show roots
		translation.y += 5
		
		# spawn vegetable to come out of the ground
		var newVegetable # something.instance()
		
		# play a sound
		
		# show particles
		
		# add to uprooted score
		
		# make vegetable a pick-up entity
		pass


func _on_PullingDistance_area_exited(area):
	uproot()
