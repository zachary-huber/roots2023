extends StaticBody


var isTethered = false
var isUprooted = false
var connectedPlunger
var count = 0
var isConnected
var player
export var tops:SpriteFrames
export var bottoms:SpriteFrames

var startTime

var b1 = preload("res://sprites/spriteFrames/bottomFrames1.tres")
var b2 = preload("res://sprites/spriteFrames/bottomFrames2.tres")
var t1 = preload("res://sprites/spriteFrames/topFrames1.tres")
var t2 = preload("res://sprites/spriteFrames/topFrames2.tres")

# Called when the node enters the scene tree for the first time.
func _ready():
	startTime = Time.get_unix_time_from_system()
	randomize()
	
	if ((randi() % 7) != 0):
		tops = t1
		bottoms = b1
	else:
		tops = t2
		bottoms = b2
	
	$skin/bottom.frames = bottoms
	$skin/top.frames = tops
	
	$skin/bottom.frame = randi() % $skin/bottom.frames.get_frame_count("default")
	$skin/top.frame = randi() % $skin/top.frames.get_frame_count("default")
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
	
	# play connected particles
	$Particles2.restart()
	
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
		
		$PlungerDetector.set_deferred("monitorable", false)
		$PlungerDetector.set_deferred("monitoring", false)
		
		
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
		if !player.isEnd: 
			player.numUprooted += 1
			print (player.numUprooted)
			player.get_parent().get_parent().get_node("HUD").get_node("VeggiesPlucked").text = "Uprooted: " + str(player.numUprooted)
		
		
		# check if vegetable > 30
		if(player.numUprooted == 20) and player.isEnd == false:
			player.isEnd = true
			# open popup for the end?
			player.get_node("endScreen").visible = true
			
			# print end message
			player.get_node("endScreen").get_node("endMessage").text = "The end!\n\n"+ "You uprooted 20 plants!\n" + "Time: " + String(stepify(Time.get_unix_time_from_system() - startTime, 1))
			
			# hide other UI elements
			var hud = player.get_parent().get_parent().get_node("HUD")
			hud.get_node("stopwatch").visible = false
			hud.get_node("VeggiesPlucked").visible = false
			
		# make vegetable a pick-up entity


func _on_PullingDistance_area_exited(area):
	if player.isConnected and !isUprooted:
		uproot()
