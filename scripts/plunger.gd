extends KinematicBody


var state = "inactive"
var velocity = Vector3.DOWN
var launchForce = 40
var gravity = Vector3.DOWN * 15 # projectile gravity
func _ready():
	pass


func _process(delta):
	if(state=="active"):
		velocity += gravity * delta
		look_at(transform.origin + velocity.normalized(), Vector3.DOWN)
		#transform.origin += velocity * delta
		move_and_slide(velocity, Vector3.UP)
	pass
	

func behaveActive():
	pass


func behaveInactive():
	pass

func isPlunger():
	return true
