extends Node

func _on_area_2d_body_entered(body):
	body.position.y = 400;
	Global_Var.moveScript.movePlayer(0);
