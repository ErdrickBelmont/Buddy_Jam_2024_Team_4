extends Node2D


enum tree_states {GROWN,CHOPPED,FIRTALIZED} 
var tree_health = 5
var current_tree_state = tree_states.GROWN
var cursor_select: bool = false
var mouse_on_tree: bool = false
@onready var collectwood = $collectwood
@onready var fertilize = $fertilize
var treeDictIndex;
var room;
var sprite;

#func _on_tree_collider_child_entered_tree(area):	
	##f area.is_in_group("player"):
		#get_node("Area2D/tree_targetted").set_visible(true)
		#print("entered in tree collider")
#
#func _on_tree_collider_child_exiting_tree(area):
	##f area.is_in_group("player"):
		#get_node(".").set_visible(false)
		#print("left tree collider")
		
func _ready():
	sprite = get_node("sprite");
	room = Global_Var.position;
	for n in range(Global_Var.treeDict[room].size()):
		var tree = Global_Var.treeDict[room][n];
		#Only necessary if the tree has already been instantiated, because on first-time spawn it will always be GROWN
		if(tree.size() > 3 && tree[3] != null):
			var treeName = tree[3].name;
			if(str(treeName) == name): 
				treeDictIndex = n;
				match tree[2]:
					3:
						current_tree_state = tree_states.CHOPPED;
					4:
						current_tree_state = tree_states.FIRTALIZED;
	if(treeDictIndex == null):
		treeDictIndex = -1;
	print(treeDictIndex);


func _on_area_entered(area):
	# gets yellow cursor child from tree
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
	# if cursor's over the tree, its clicked, and the player has at least 1 energy left #&& Global_Var.lowerBoundCheck(Global_Var.get_referance("energy"),1)d
	if(cursor_select && mouse_on_tree && Input.is_action_just_pressed("left_Click") && Global_Var.lowerBoundCheck(Global_Var.get_referance("energy"),1) ):
		match current_tree_state:
			tree_states.GROWN:
				SignalBus.player_swing.emit()
				tree_health -= 1
				collectwood.play()
				Global_Var.add_to_var("wood",1)
				Global_Var.add_to_var("energy", -1)
				print(tree_health)
				if(tree_health == 0):
					#Change sprite
					Global_Var.treeDict[room][treeDictIndex][2] = 3;
					sprite.set_cell(0, Vector2(-1, -1), 1, Vector2(3, 0))
					current_tree_state = tree_states.CHOPPED
					print("trees been chopped")
			tree_states.CHOPPED:
				if(Global_Var.dic.fertilizer > 0):
					#Change sprite
					Global_Var.treeDict[room][treeDictIndex][2] = 4;
					sprite.set_cell(0, Vector2(-1, -1), 1, Vector2(4, 0))
					fertilize.play()
					Global_Var.add_to_var("fertilizer", -1)
					current_tree_state = tree_states.FIRTALIZED
					print("fertilized")
			_:
				print("other")
			
		



