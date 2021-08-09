extends KinematicBody2D

signal popped

export var speed = 64
export var hp = 100
export (ImageTexture) var popping_tex

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
			
		elif collider_name == "Bubble" or "@Bubble@" in collider_name:
			velocity = collider.velocity.normalized().reflect(velocity)
			add_hp(-10)
			
			
func add_hp(inc):
	#Update the HP of this bubble
	hp += inc
	
	#Did the bubble pop?
	if hp <= 0:
		#Change the bubble's texture to the popping texture,
		#turn off event processing, and turn off collision
		#detection
		get_node("Sprite").set_texture(popping_tex)
		set_fixed_process(false)
		set_layer_mask(0)
		set_collision_mask(0)
		
		#Play the popping sound effect and start the pop timer
		get_node("SamplePlayer2D").play("popping-bubble")
		get_node("PopTimer").start()


func _on_PopTimer_timeout():
	#Emit the "popped" signal and free this bubble
	emit_signal("popped")
	queue_free()
