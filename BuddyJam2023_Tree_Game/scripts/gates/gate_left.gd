extends Node

func _on_area_2d_body_entered(body):
	print("Multiple entry2")
	body.position.x = 750;
	var parent = get_parent().get_parent().get_parent().get_parent().get_parent(); #Man fuck this lmfao
	#Parent is Root_Node2D in forest_entrance
	if(Global_Var.moveCooldown):
		Global_Var.moveCooldown = false;
		parent.get_node("Timer").start(0.3);
		parent.get_node("RoomToRoom").call_deferred("movePlayer", 1);
