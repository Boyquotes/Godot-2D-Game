extends Control

signal restart


func _ready():
	pass
	
	
func _on_RestartButton_pressed():
	#Emit restart signal
	emit_signal("restart")


func show_high_score(score, is_new):
	#Update high score label and display high score dialog
	get_node("PopupPanel/HighScoreLabel").set_text(
	    "High Score: " + str(score) + 
	    (" New!" if is_new else "")
	)
	get_node("PopupPanel").popup()
