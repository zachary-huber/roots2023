extends StaticBody


var isTethered = false
var isUprooted = false
var connectedPlunger
var count = 0
var isConnected
var player


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if(isTethered):
		pass


func _on_PlungerDetector_body_entered(body):
	if body.has_method("isPlunger") and (!isUprooted):
		connectedPlunger = connectPlunger(body)


func connectPlunger(body):
	print("connecting plunger to vegetable")
	
	# move plunger into position
	body.translation = translation
	body.translation.y += 1
	body.state = "inactive"
	body.scale = Vector3(.8,.8,.8)
	
	# emit signal that contact was made
	player = body.get_parent().get_parent().get_node("Player")
	player.isConnected = true
	
	# activate the pulling detector
	$PullingDistance.monitorable = true
	$PullingDistance.monitoring = true
	
	# apply particle affect
	
	return body



func uproot():
	if(!isUprooted):
		
		if !player.isConnected:
			return
		
		print("uprooting vegetable!")
		isUprooted = true
		$PullingDistance.set_deferred("monitorable", false)
		$PullingDistance.set_deferred("monitoring", false)
		
		
		# hide plunger
		connectedPlunger.visible = false

		$AnimationPlayer.play("uproot")
		$Particles.emitting = true
		
		player.isConnected = false
		
		# make the tether invisible
		player.get_node("tether").visible = false
		
		# make the cannon plunger visible
		player.get_node("plungerProjectile").visible = true
		
		# enable launchPlunger
		player.canLaunchPlunger = true
		
		# delete plunger
		connectedPlunger.queue_free()
		
		# play a sound
		$vegetableSounds.play()
		
		
		# add to uprooted score
		player.numUprooted += 1
		print (player.numUprooted)
		player.get_parent().get_parent().get_node("HUD").get_node("VeggiesPlucked").text = "Uprooted: " + str(player.numUprooted)

		# make vegetable a pick-up entity


func _on_PullingDistance_area_exited(area):
	if player.isConnected:
		uproot()
