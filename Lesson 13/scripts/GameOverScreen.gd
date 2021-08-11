extends Control


func _ready():
	pass


func show_high_score(score):
	#Display high score dialog
	get_node("PopupPanel").popup()
