extends CharacterBody2D


const SPEED = 50.0
var player_chase = false
var player = null
var player_contact = false
var bug_health = 3
var cursor_select: bool = false
var mouse_on_tree: bool = false
@onready var axeattack = $axeattack
@onready var bugattack = $bugattack
@onready var bugtakedamage = $bugtakedamage

# BUG: the _on_area_2d_body_entered's subtracting 1 from energy at start of game and IDK why.
# ready function adding 1 energy is a jerry rigged solution to this problem


func _ready():
	Global_Var.add_to_var("energy", 1)
func _physics_process(delta):
	if player_chase:
		position += (player.position - position) / SPEED
	

func _on_radar_body_entered(body):
	player = body
	player_chase = true

func _on_radar_body_exited(body):
	player = null
	player_chase = false
	

func _on_area_2d_body_exited(body):
	player_contact = false
	pass # Replace with function body.

func _on_area_2d_body_entered(body):
	player_contact = true
	if player_contact == true:
		bugattack.play()
		Global_Var.add_to_var("energy", -1)





#func _on_tree_collider_child_entered_tree(area):	
	##f area.is_in_group("player"):
		#get_node("Area2D/tree_targetted").set_visible(true)
		#print("entered in tree collider")
#
#func _on_tree_collider_child_exiting_tree(area):
	##f area.is_in_group("player"):
		#get_node(".").set_visible(false)
		#print("left tree collider")

func _process(delta):
	# if cursor's over the tree, its clicked, and the player has at least 1 energy left #&& Global_Var.lowerBoundCheck(Global_Var.get_referance("energy"),1)d
	if(cursor_select && mouse_on_tree && Input.is_action_just_pressed("left_Click") && Global_Var.lowerBoundCheck(Global_Var.get_referance("energy"),1) ):
		bug_health -= 1
		axeattack.play()
		bugtakedamage.play()
		
		SignalBus.player_swing.emit()
		if bug_health == 0:
			Global_Var.add_to_var("fertilizer", 1)
			self.free()
			
		




#code from : https://forum.godotengine.org/t/is-there-a-wait-function-to-godot/38759
#func wait(seconds: float) -> void:
	#await get_tree().create_timer(seconds).timeout




func _on_area_2d_area_entered(area):
	get_child(0,false).show()
	cursor_select = true
	pass # Replace with function body.


func _on_area_2d_area_exited(area):
	get_child(0,false).hide()
	cursor_select = false
	pass # Replace with function body.


func _on_area_2d_mouse_entered():
	mouse_on_tree = true
	pass # Replace with function body.


func _on_area_2d_mouse_exited():
	mouse_on_tree = false
	pass # Replace with function body.
