extends KinematicBody2D

export var speed = 64
export var hp = 100

var velocity


func _ready():
	#Randomize the initial velocity of the bubble
	velocity = Vector2(speed, 0).rotated(deg2rad(rand_range(0, 360)))
	
	#Enable event processing
	set_fixed_process(true)
	
	
func _fixed_process(delta):
	#Update bubble position
	move(velocity * delta)
	
	#Update velocity
	if is_colliding():
		var collider = get_collider()
		var collider_name = collider.get_name()
		
		if collider_name in ["Wall-L", "Wall-R"]:
			velocity = Vector2(1, 0).reflect(velocity)
			
		elif collider_name in ["Wall-T", "Wall-B"]:
			velocity = Vector2(0, 1).reflect(velocity)
