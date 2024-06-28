extends Node

func _on_area_2d_body_entered(body):
	print("Multiple entry1")
	body.position.y = -375;
	var parent = get_parent().get_parent().get_parent().get_parent().get_parent(); #Man fuck this lmfao
	if(Global_Var.moveCooldown):
		Global_Var.moveCooldown = false;
		parent.get_node("Timer").start(0.3);
		parent.get_node("RoomToRoom").call_deferred("movePlayer", 3);
