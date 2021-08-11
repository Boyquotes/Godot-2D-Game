extends Control

signal restart


func _ready():
	pass
	
	
func _on_RestartButton_pressed():
	#Emit restart signal
	emit_signal("restart")


func show_high_score(score):
	#Display high score dialog
	get_node("PopupPanel").popup()
