extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Global_Var.quota_reached == false:
		get_child(2,false).show()
	if Global_Var.base_fortified == false:
		get_child(1,false).show()
	pass


func _on_button_pressed():
	var base_fortified: bool = false
	var quota_reached: bool = false
	get_tree().change_scene_to_file("res://scenes/start_screen.tscn")
	pass # Replace with function body.
