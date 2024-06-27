extends Node

func _on_area_2d_body_entered(body):
	body.position.x = -775;
	Global_Var.moveScript.movePlayer(2);
