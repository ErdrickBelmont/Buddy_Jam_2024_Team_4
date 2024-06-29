extends Area2D

func _ready():
	get_child(-1).set_visible(false) 

#func resume():
	#get_tree().paused = false
	#hide()
#func pause():
	#get_tree().paused = true
	#
#
#func _on_resume_pressed():
	#resume()
#
#func _on_options_pressed():
	#resume()
	#get_tree().reload_current_scene()
#
#func _on_quit_pressed():
	#get_tree().quit()



func _on_area_entered(area):
	get_child(-1).set_visible(true) 
	print("area entered")

func _on_area_exited(area):
	get_child(-1).set_visible(false) 
	pass # Replace with function body.


func _on_return_to_ship_pressed():
	get_tree().change_scene_to_file("res://shipUpgradeScene.tscn")


