extends Control


func _ready():
	pass
	
	
func set_score(score):
	#Update the score label
	get_node("ScoreLabel").set_text("Score: " + str(score))
	
	
func set_time(time):
	#Update the time label
	get_node("TimeLabel").set_text("Time: " + str(time))
