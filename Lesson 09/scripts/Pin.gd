extends KinematicBody2D

var target_pos = Vector2()


func _ready():
	#Enable event processing
	set_process_input(true)
	set_fixed_process(true)
	

func _input(event):
	#Update pin target position
	if (event.type == InputEvent.SCREEN_TOUCH or 
	    event.type == InputEvent.SCREEN_DRAG):
		target_pos = event.pos
		
		
func _fixed_process(delta):
	#Update pin position
	move_to(target_pos)
	
	#Pop any bubbles the pin touched
	if is_colliding():
		var collider = get_collider()
		var collider_name = collider.get_name()
		
		if collider_name == "Bubble" or "@Bubble@" in collider_name:
			collider.add_hp(-100)
