extends Node

export (PackedScene) var Bubble
export var max_bubble_cnt = 10

var screen_rect
var bubble_cnt = 0
var score
var time


func _ready():
	#Initialize random number generator and get screen rect
	randomize()
	screen_rect = get_viewport().get_rect()
	
	#Start the game
	start_game()


func _on_SpawnTimer_timeout():
	#Spawn a new bubble if there are less than 10 bubbles in
	#play
	if bubble_cnt >= max_bubble_cnt:
		return
		
	var bubble = Bubble.instance()
	var pos = Vector2(
	    rand_range(screen_rect.pos.x, screen_rect.end.x),
	    rand_range(screen_rect.pos.y, screen_rect.end.y)
	)
	bubble.set_pos(pos)
	add_child(bubble)
	bubble_cnt += 1
	
	#Connect "popped" signal
	bubble.connect("popped", self, "_on_Bubble_popped")
	
	
func _on_Bubble_popped():
	#Decrease the bubble count by 1 and increase score
	bubble_cnt -= 1
	score += 100
	get_node("UI/HUD").set_score(score)
	
	
func _on_GameTimer_timeout():
	#Update the timer variable
	time -= 1
	get_node("UI/HUD").set_time(time)
	
	
func start_game():
	#Reset the bubble count, score, and time. Then start the 
	#spawn and game timers.
	bubble_cnt = 0
	score = 0
	time = 120
	get_node("SpawnTimer").start()
	get_node("GameTimer").start()
