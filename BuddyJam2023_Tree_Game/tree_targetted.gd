extends Node2D


enum tree_states {GROWN,CHOPPED,FIRTALIZED} 
var tree_health = 5
var current_tree_state = tree_states.GROWN
var cursor_select: bool = false
var mouse_on_tree: bool = false

#func _on_tree_collider_child_entered_tree(area):	
	##f area.is_in_group("player"):
		#get_node("Area2D/tree_targetted").set_visible(true)
		#print("entered in tree collider")
#
#func _on_tree_collider_child_exiting_tree(area):
	##f area.is_in_group("player"):
		#get_node(".").set_visible(false)
		#print("left tree collider")


func _on_area_entered(area):
	#if(area.name == )
	get_child(1,false).show()
	cursor_select = true
	
func _on_area_exited(area):
	get_child(1,false).hide()
	cursor_select = false
	pass # Replace with function body.
	
func _on_mouse_entered():
	mouse_on_tree = true
	pass # Replace with function body.
	


func _on_mouse_exited():
	mouse_on_tree = false
	pass # Replace with function body.
	
func _process(delta):
	if(cursor_select && mouse_on_tree && Input.is_action_just_pressed("left_Click")):
		match current_tree_state:
			tree_states.GROWN:
				tree_health -= 1
				print(tree_health)
				if(tree_health == 0):
					current_tree_state = tree_states.CHOPPED
					print("trees been chopped")
			tree_states.CHOPPED:
				current_tree_state = tree_states.FIRTALIZED
				print("fertilized")
			_:
				print("tree already fertilzied")
			
		



